class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "3765c0ad19e6cca81298d6cfa095f21915cf9f6d436e62a64e026cde289e441c"
  license "MIT"

  def install
    bin.install "bin/mgit"
  end

  test do
    assert_match "mgit #{version}", shell_output("#{bin}/mgit --version")
    assert_match "Usage: mgit", shell_output("#{bin}/mgit --help")
  end
end
