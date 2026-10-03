# frozen_string_literal: true

require "minitest/autorun"
require_relative "../scripts/propose-tool-release"

class ProposeToolReleaseTest < Minitest::Test
  EXISTING = { "source_repository" => "knowledgeislands/tools-ki", "version" => "v0.4.0" }.freeze
  SOURCE = <<~RUBY
    class Ki < Formula
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-arm64.tar.gz"
      sha256 "#{'a' * 64}"
      license "MIT"
    end
  RUBY
  RELEASE = {
    "tag_name" => "v0.5.0", "draft" => false, "prerelease" => false, "immutable" => true,
    "assets" => [{ "name" => "ki-v0.5.0-darwin-arm64.tar.gz" }]
  }.freeze

  def update(source = SOURCE, release = RELEASE)
    ProposeToolRelease.update(source, EXISTING, release, fetch: ->(_url) { "archive bytes" })
  end

  def test_updates_only_release_url_and_checksum
    result = update
    assert_includes result, "/v0.5.0/ki-v0.5.0-darwin-arm64.tar.gz"
    assert_includes result, Digest::SHA256.hexdigest("archive bytes")
    assert_includes result, 'license "MIT"'
    refute_includes result, "/v0.4.0/"
  end

  def test_unchanged_release_is_idempotent
    assert_equal SOURCE, update(SOURCE, RELEASE.merge("tag_name" => "v0.4.0"))
  end

  def test_rejects_mutable_prerelease_and_downgrade
    assert_raises(RuntimeError) { update(SOURCE, RELEASE.merge("immutable" => false)) }
    assert_raises(RuntimeError) { update(SOURCE, RELEASE.merge("prerelease" => true)) }
    assert_raises(RuntimeError) { update(SOURCE, RELEASE.merge("tag_name" => "v0.3.0")) }
  end

  def test_rejects_missing_asset_or_unpaired_checksum
    assert_raises(RuntimeError) { update(SOURCE, RELEASE.merge("assets" => [])) }
    assert_raises(RuntimeError) { update(SOURCE.sub("sha256", "checksum")) }
  end

  def test_rejects_unexpected_release_url
    source = SOURCE.sub("knowledgeislands/tools-ki", "knowledgeislands/tools-rig")
    assert_raises(RuntimeError) { update(source) }
  end

  def test_accepts_immutable_tag_archive
    old = "https://github.com/knowledgeislands/tools-ki/archive/refs/tags/v0.4.0.tar.gz"
    source = "url \"#{old}\"\nsha256 \"#{'a' * 64}\"\n"
    result = update(source, RELEASE.merge("assets" => []))
    assert_includes result, "archive/refs/tags/v0.5.0.tar.gz"
  end

  def test_updates_every_platform_archive_in_current_ki_formula
    path = File.expand_path("../Formula/ki.rb", __dir__)
    source = File.read(path)
    existing = ToolReleaseEvents.from_formula(path)
    assets = source.scan(/url "[^"]+\/([^\/"\n]+)"/).flatten.map do |name|
      { "name" => name.gsub(existing.fetch("version"), "v0.6.0") }
    end
    release = RELEASE.merge("tag_name" => "v0.6.0", "assets" => assets)
    result = ProposeToolRelease.update(source, existing, release, fetch: ->(_url) { "archive bytes" })
    assert_equal 3, result.scan(/url "[^"]+v0\.6\.0[^"]*"/).length
    assert_equal 3, result.scan(/sha256 "#{Digest::SHA256.hexdigest('archive bytes')}"/).length
    refute_includes result, existing.fetch("version")
  end
end
