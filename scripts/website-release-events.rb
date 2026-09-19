#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

module WebsiteReleaseEvents
  RELEASE_URL = %r{\Ahttps://github\.com/(?<repository>knowledgeislands/[a-z0-9-]+)/(?:releases/download|archive/refs/tags)/(?<version>v\d+\.\d+\.\d+)(?:/|\.tar\.gz\z)}

  module_function

  def from_formula(path)
    source = File.read(path)
    urls = source.scan(/^\s*url\s+"([^"]+)"/).flatten
    raise "#{path}: formula must declare at least one url" if urls.empty?

    releases = urls.map do |url|
      match = RELEASE_URL.match(url)
      raise "#{path}: unsupported release url #{url}" unless match

      [match[:repository], match[:version]]
    end.uniq

    raise "#{path}: release urls disagree on repository or version" unless releases.one?

    repository, version = releases.fetch(0)
    {
      "tool" => File.basename(path, ".rb"),
      "source_repository" => repository,
      "version" => version,
      "formula_path" => path
    }
  end
end

if $PROGRAM_NAME == __FILE__
  abort "usage: #{File.basename($PROGRAM_NAME)} Formula/<tool>.rb [...]" if ARGV.empty?

  ARGV.each { |path| puts JSON.generate(WebsiteReleaseEvents.from_formula(path)) }
end
