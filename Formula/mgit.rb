class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "092a6df6d633b2c5d025e9e05d871fac9fcc67aa4e3e14d68cd887a768aea1ac"
  license "MIT"

  def install
    bin.install "bin/mgit"
  end

  test do
    assert_match "mgit #{version}", shell_output("#{bin}/mgit --version")
    assert_match "Usage: mgit", shell_output("#{bin}/mgit --help")
  end
end
