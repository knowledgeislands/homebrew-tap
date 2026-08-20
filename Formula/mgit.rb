class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "93ba4c6e31b89bb2746509472f3f4fcfc439c3fd3aa2fd61406ea7c227a46286"
  license "MIT"

  def install
    bin.install "bin/mgit"
    man1.install "man/mgit.1"
  end

  test do
    assert_match "mgit #{version}", shell_output("#{bin}/mgit --version")
    assert_match "Usage: mgit", shell_output("#{bin}/mgit --help")
  end
end
