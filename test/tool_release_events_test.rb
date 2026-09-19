# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "tmpdir"
require_relative "../scripts/tool-release-events"

class ToolReleaseEventsTest < Minitest::Test
  def with_file(name, source)
    Dir.mktmpdir do |directory|
      path = File.join(directory, name)
      File.write(path, source)
      yield path
    end
  end

  def with_formula(source, &block)
    with_file("ki.rb", source, &block)
  end

  def with_registry(value, &block)
    with_file("consumers.json", JSON.generate(value), &block)
  end

  def test_extracts_one_release_from_multi_platform_urls
    with_formula(<<~RUBY) do |path|
      class Ki < Formula
        url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-arm64.tar.gz"
        url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-linux-x64.tar.gz"
      end
    RUBY
      assert_equal(
        {
          "tool" => "ki",
          "source_repository" => "knowledgeislands/tools-ki",
          "version" => "v0.4.0",
          "formula_path" => path
        },
        ToolReleaseEvents.from_formula(path)
      )
    end
  end

  def test_accepts_tag_archive_release
    with_formula('url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.13.0.tar.gz"') do |path|
      event = ToolReleaseEvents.from_formula(path)
      assert_equal "knowledgeislands/tools-mgit", event.fetch("source_repository")
      assert_equal "v0.13.0", event.fetch("version")
    end
  end

  def test_rejects_non_tools_repository
    with_formula('url "https://github.com/knowledgeislands/ki-website/archive/refs/tags/v0.4.0.tar.gz"') do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.from_formula(path) }
      assert_includes error.message, "unsupported tools release url"
    end
  end

  def test_rejects_formula_without_url
    with_formula("class Ki < Formula\nend\n") do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.from_formula(path) }
      assert_includes error.message, "at least one url"
    end
  end

  def test_rejects_non_release_url
    with_formula('url "https://example.com/ki-v0.4.0.tar.gz"') do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.from_formula(path) }
      assert_includes error.message, "unsupported tools release url"
    end
  end

  def test_rejects_urls_that_disagree
    with_formula(<<~RUBY) do |path|
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-arm64.tar.gz"
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.1/ki-v0.4.1-linux-x64.tar.gz"
    RUBY
      error = assert_raises(RuntimeError) { ToolReleaseEvents.from_formula(path) }
      assert_includes error.message, "release urls disagree"
    end
  end

  def test_loads_sorted_unique_consumers
    with_registry("consumers" => ["knowledgeislands/ki-website", "knowledgeislands/tool-catalogue"]) do |path|
      assert_equal(
        ["knowledgeislands/ki-website", "knowledgeislands/tool-catalogue"],
        ToolReleaseEvents.consumers_from(path)
      )
    end
  end

  def test_rejects_unknown_registry_properties
    with_registry("consumers" => ["knowledgeislands/ki-website"], "enabled" => true) do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.consumers_from(path) }
      assert_includes error.message, "only a consumers array"
    end
  end

  def test_rejects_empty_consumers
    with_registry("consumers" => []) do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.consumers_from(path) }
      assert_includes error.message, "non-empty array"
    end
  end

  def test_rejects_unsorted_or_duplicate_consumers
    with_registry("consumers" => ["knowledgeislands/zeta", "knowledgeislands/alpha"]) do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.consumers_from(path) }
      assert_includes error.message, "unique and sorted"
    end

    with_registry("consumers" => ["knowledgeislands/ki-website", "knowledgeislands/ki-website"]) do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.consumers_from(path) }
      assert_includes error.message, "unique and sorted"
    end
  end

  def test_rejects_consumer_outside_knowledgeislands
    with_registry("consumers" => ["someone/ki-website"]) do |path|
      error = assert_raises(RuntimeError) { ToolReleaseEvents.consumers_from(path) }
      assert_includes error.message, "invalid consumer repository"
    end
  end
end
