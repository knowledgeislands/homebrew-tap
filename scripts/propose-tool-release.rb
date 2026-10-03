#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "json"
require "open-uri"
require_relative "tool-release-events"

module ProposeToolRelease
  VERSION = /\Av\d+\.\d+\.\d+\z/
  URL_AND_SHA = /(?<indent>^[ \t]*)url "(?<url>[^"]+)"\n\k<indent>sha256 "(?<sha>[a-f0-9]{64})"/m
  module_function

  def update(source, existing, release, fetch:)
    new_version = release.fetch("tag_name")
    old_version = existing.fetch("version")
    raise "invalid release version" unless VERSION.match?(new_version)
    raise "release is not published and immutable" unless release["draft"] == false && release["prerelease"] == false && release["immutable"] == true
    return source if new_version == old_version

    old_parts = old_version.delete_prefix("v").split(".").map(&:to_i)
    new_parts = new_version.delete_prefix("v").split(".").map(&:to_i)
    raise "refusing version downgrade" unless (new_parts <=> old_parts) == 1

    urls = source.scan(/^\s*url "([^"]+)"/).flatten
    pairs = source.scan(URL_AND_SHA)
    raise "every formula url needs an adjacent sha256" unless !urls.empty? && pairs.length == urls.length

    assets = release.fetch("assets").map { |asset| asset.fetch("name") }
    updated = source.gsub(URL_AND_SHA) do
      indent = Regexp.last_match[:indent]
      old_url = Regexp.last_match[:url]
      release_url = %r{\Ahttps://github\.com/#{Regexp.escape(existing.fetch("source_repository"))}/releases/download/#{Regexp.escape(old_version)}/}
      archive_url = %r{\Ahttps://github\.com/#{Regexp.escape(existing.fetch("source_repository"))}/archive/refs/tags/#{Regexp.escape(old_version)}\.tar\.gz\z}
      if release_url.match?(old_url)
        asset = old_url.split("/").last.sub(old_version, new_version)
        raise "new release lacks asset #{asset}" unless assets.include?(asset)
      elsif !archive_url.match?(old_url)
        raise "formula url is not the declared source release: #{old_url}"
      end
      new_url = old_url.gsub(old_version, new_version)
      digest = Digest::SHA256.hexdigest(fetch.call(new_url))
      "#{indent}url \"#{new_url}\"\n#{indent}sha256 \"#{digest}\""
    end
    raise "formula update changed no release urls" if updated == source
    updated
  end
end

if $PROGRAM_NAME == __FILE__
  abort "usage: propose-tool-release.rb Formula/<tool>.rb <release.json>" unless ARGV.length == 2
  formula, release_path = ARGV
  abort "formula path is outside Formula/" unless %r{\AFormula/[a-z0-9]+(?:-[a-z0-9]+)*\.rb\z}.match?(formula)
  existing = ToolReleaseEvents.from_formula(formula)
  release = JSON.parse(File.read(release_path))
  source = File.read(formula)
  updated = ProposeToolRelease.update(source, existing, release, fetch: ->(url) { URI.open(url, read_timeout: 120).read })
  if updated == source
    puts "#{formula}: already current"
  else
    File.write(formula, updated)
    puts "#{formula}: prepared #{release.fetch('tag_name')}"
  end
end
