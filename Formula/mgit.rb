class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "22b1bf235c0c0fa6afbde753787638916d71d8edf84d8c052a56be807b44349b"
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
