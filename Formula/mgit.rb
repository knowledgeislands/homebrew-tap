class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "114e64cd67916370685798a6da962892ed68c586e979af0d899b29c4d436c9a3"
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
