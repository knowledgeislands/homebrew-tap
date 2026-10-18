class Rig < Formula
  desc "Describe and manage a person's working setup"
  homepage "https://github.com/knowledgeislands/tools-rig"
  url "https://github.com/knowledgeislands/tools-rig/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "245f8a381344f71a82363875b837bc3eed25990e57b7146d5ced1a67c92cc0c4"
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
