class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  url "https://github.com/knowledgeislands/tools-ki/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "27d1c87f0929d0fce284e22d17fd003d4d0921fb01fca40bf4e6e19f017be122"
  license "MIT"

  def install
    bin.install "bin/ki"
  end

  test do
    assert_match "ki #{version}", shell_output("#{bin}/ki --version")
    assert_match "Usage: ki", shell_output("#{bin}/ki --help")
  end
end
