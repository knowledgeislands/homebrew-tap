class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.1/ki-v0.8.1-darwin-arm64.tar.gz"
      sha256 "6ae25f87af3db786fb5e9c360df02673d87fe44bb874190e412ad8b2b0d1c366"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.1/ki-v0.8.1-darwin-x64.tar.gz"
      sha256 "2c1496650bca2f83e9892f8c484a5b5190fbc6a9bf71825ec8ce73c8d0a8ecad"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.1/ki-v0.8.1-linux-x64.tar.gz"
      sha256 "7ed585fde73eb03e3a1c449815850a65554070f9197e1a3585686de99b45fdc9"
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
