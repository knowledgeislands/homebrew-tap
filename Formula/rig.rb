class Rig < Formula
  desc "Describe and manage a person's working setup"
  homepage "https://github.com/knowledgeislands/tools-rig"
  url "https://github.com/knowledgeislands/tools-rig/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5edcbe3b0a753b499c7dcb1b62640957c61f24b378cd2d3a520af01e10fd2bf6"
  license "MIT"

  def install
    bin.install "bin/rig"
    man1.install "man/rig.1"
  end

  test do
    assert_equal "rig #{version}\n", shell_output("#{bin}/rig --version")
    assert_match "Usage: rig", shell_output("#{bin}/rig --help")
  end
end
