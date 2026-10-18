class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.2/ki-v0.11.2-darwin-arm64.tar.gz"
      sha256 "cc3468a54bdda30db2cad526a5be92c391f86540a493a45a9dbc095af2d6b3af"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.2/ki-v0.11.2-darwin-x64.tar.gz"
      sha256 "5dd2573981ac0d2621a9d626baf99657ad6d8f14e850b855eecae3e772c0e893"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.2/ki-v0.11.2-linux-x64.tar.gz"
      sha256 "3e549e264b1d4594c24e644229e6582c8877ecbd1ecead1bb42be4e1bba9663f"
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
