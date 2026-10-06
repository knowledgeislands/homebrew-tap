class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.1/ki-v0.7.1-darwin-arm64.tar.gz"
      sha256 "cc15067d86e7bcb82bfcb5efaf95a0650fad795fcad35d003c11ec5e423df742"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.1/ki-v0.7.1-darwin-x64.tar.gz"
      sha256 "224f9ea3c18126f42a0dddf1131f72682e85f1cde5b7f1eb56a2d96fd1b91d86"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.1/ki-v0.7.1-linux-x64.tar.gz"
      sha256 "2ca118dd6a7273a3142f229489e1133eca11878e7ef53cf4af3f7b1b132a2ac2"
    end
  end

  def install
    bin.install "ki"
    man1.install "man/ki.1"
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/ki --version")
  end
end
