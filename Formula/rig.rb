class Rig < Formula
  desc "Describe and manage a person's working setup"
  homepage "https://github.com/knowledgeislands/tools-rig"
  url "https://github.com/knowledgeislands/tools-rig/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "aca2a7b0904c2b57b4033a2e265391acc364cd5d6007b86eb4b03cb60a5d0cfe"
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
