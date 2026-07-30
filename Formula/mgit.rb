class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "8dda07df850bb0acd1a709dd5264a38325f070fd3513ba41ad281acd85aeec65"
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
