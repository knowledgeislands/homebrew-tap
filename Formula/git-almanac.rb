class GitAlmanac < Formula
  desc "Inspect a local Git repository's calendars, authors, and reports offline"
  homepage "https://github.com/knowledgeislands/tools-git-almanac"
  url "https://github.com/knowledgeislands/tools-git-almanac/releases/download/v0.2.0/git-almanac-v0.2.0.tar.gz"
  sha256 "bc66dba9cee8e41631f20e002e114866eec5ca5c5d44d5d45f22990c3079a068"
  license "MIT"

  depends_on "node"

  def install
    bin.install "git-almanac"
    man1.install "git-almanac.1"
  end

  test do
    assert_match "git-almanac #{version}", shell_output("#{bin}/git-almanac --version")
    assert_match "git almanac calendar", shell_output("#{bin}/git-almanac --help")
  end
end
