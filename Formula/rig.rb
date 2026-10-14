class Rig < Formula
  desc "Describe and manage a person's working setup"
  homepage "https://github.com/knowledgeislands/tools-rig"
  url "https://github.com/knowledgeislands/tools-rig/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "1be1dfbdd6e6f994a7625ef7c915f5260d831e6890fa7962b694593677937aa1"
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
