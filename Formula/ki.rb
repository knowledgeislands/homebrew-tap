class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.0/ki-v0.11.0-darwin-arm64.tar.gz"
      sha256 "d90b08b0699ad0994a932a3671a04297e31fdb53ceb61070d2cbaa632b7520f2"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.0/ki-v0.11.0-darwin-x64.tar.gz"
      sha256 "e63d771256b94d960e1218ea2f3983f032b61d47f1664d6d33148d0c41cf2af6"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.0/ki-v0.11.0-linux-x64.tar.gz"
      sha256 "216b43c2c3d52dc79d98b954cb432caa470e599da4515fdb55d371305671ccaf"
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
