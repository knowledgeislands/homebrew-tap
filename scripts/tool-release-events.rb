#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

module ToolReleaseEvents
  RELEASE_URL = %r{\Ahttps://github\.com/(?<repository>knowledgeislands/tools-[a-z0-9-]+)/(?:releases/download|archive/refs/tags)/(?<version>v\d+\.\d+\.\d+)(?:/|\.tar\.gz\z)}
  CONSUMER_REPOSITORY = %r{\Aknowledgeislands/[a-z0-9]+(?:-[a-z0-9]+)*\z}

  module_function

  def from_formula(path)
    source = File.read(path)
    urls = source.scan(/^\s*url\s+"([^"]+)"/).flatten
    raise "#{path}: formula must declare at least one url" if urls.empty?

    releases = urls.map do |url|
      match = RELEASE_URL.match(url)
      raise "#{path}: unsupported tools release url #{url}" unless match

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

  def consumers_from(path)
    document = JSON.parse(File.read(path))
    unless document.is_a?(Hash) && document.keys == ["consumers"]
      raise "#{path}: registry must contain only a consumers array"
    end

    consumers = document.fetch("consumers")
    raise "#{path}: consumers must be a non-empty array" unless consumers.is_a?(Array) && !consumers.empty?
    raise "#{path}: consumers must be unique and sorted" unless consumers == consumers.uniq.sort

    consumers.each do |repository|
      unless repository.is_a?(String) && CONSUMER_REPOSITORY.match?(repository)
        raise "#{path}: invalid consumer repository #{repository.inspect}"
      end
    end

    consumers
  rescue JSON::ParserError => e
    raise "#{path}: invalid JSON: #{e.message}"
  end
end

if $PROGRAM_NAME == __FILE__
  command = ARGV.shift
  case command
  when "release"
    abort "usage: #{File.basename($PROGRAM_NAME)} release Formula/<tool>.rb [...]" if ARGV.empty?
    ARGV.each { |path| puts JSON.generate(ToolReleaseEvents.from_formula(path)) }
  when "consumers"
    abort "usage: #{File.basename($PROGRAM_NAME)} consumers <registry.json>" unless ARGV.one?
    ToolReleaseEvents.consumers_from(ARGV.fetch(0)).each { |repository| puts repository }
  else
    abort "usage: #{File.basename($PROGRAM_NAME)} release Formula/<tool>.rb [...] | consumers <registry.json>"
  end
end
