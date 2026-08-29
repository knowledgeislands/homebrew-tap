class GitAlmanac < Formula
  desc "Inspect a local Git repository's calendars, authors, and reports offline"
  homepage "https://github.com/knowledgeislands/tools-git-almanac"
  url "https://github.com/knowledgeislands/tools-git-almanac/releases/download/v0.1.0/git-almanac-v0.1.0.tar.gz"
  sha256 "800260831367f40fce693bec3764f70d263cee97006ca406803f02db67e2e10c"
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
