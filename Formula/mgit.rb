class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "9dfb59afb8f27db520a5ad5310901dca046b270241d9198af87bd7f47267f9a8"
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
