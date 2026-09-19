# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require_relative "../scripts/website-release-events"

class WebsiteReleaseEventsTest < Minitest::Test
  def with_formula(source)
    Dir.mktmpdir do |directory|
      path = File.join(directory, "ki.rb")
      File.write(path, source)
      yield path
    end
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
        WebsiteReleaseEvents.from_formula(path)
      )
    end
  end

  def test_accepts_tag_archive_release
    with_formula('url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.13.0.tar.gz"') do |path|
      event = WebsiteReleaseEvents.from_formula(path)
      assert_equal "knowledgeislands/tools-mgit", event.fetch("source_repository")
      assert_equal "v0.13.0", event.fetch("version")
    end
  end

  def test_rejects_formula_without_url
    with_formula("class Ki < Formula\nend\n") do |path|
      error = assert_raises(RuntimeError) { WebsiteReleaseEvents.from_formula(path) }
      assert_includes error.message, "at least one url"
    end
  end

  def test_rejects_non_release_url
    with_formula('url "https://example.com/ki-v0.4.0.tar.gz"') do |path|
      error = assert_raises(RuntimeError) { WebsiteReleaseEvents.from_formula(path) }
      assert_includes error.message, "unsupported release url"
    end
  end

  def test_rejects_urls_that_disagree
    with_formula(<<~RUBY) do |path|
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-arm64.tar.gz"
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.1/ki-v0.4.1-linux-x64.tar.gz"
    RUBY
      error = assert_raises(RuntimeError) { WebsiteReleaseEvents.from_formula(path) }
      assert_includes error.message, "release urls disagree"
    end
  end
end
