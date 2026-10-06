class Rig < Formula
  desc "Describe and manage a person's working setup"
  homepage "https://github.com/knowledgeislands/tools-rig"
  url "https://github.com/knowledgeislands/tools-rig/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "884829c6870645960a7c5eb44f5d80204544c9297ef772b62ae7d9422ed71724"
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
