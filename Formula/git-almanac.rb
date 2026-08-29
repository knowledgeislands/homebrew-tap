class GitAlmanac < Formula
  desc "Inspect a local Git repository's calendars, authors, and reports offline"
  homepage "https://github.com/knowledgeislands/tools-git-almanac"
  url "https://github.com/knowledgeislands/tools-git-almanac/releases/download/v1.0.1/git-almanac-v1.0.1.tar.gz"
  sha256 "4a2bdf14cac743a0dbea350f40900cc8324b6b72c251e7b742712fad40087d81"
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
