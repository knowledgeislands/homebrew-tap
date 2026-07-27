class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  version "0.2.6"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.6/ki-v0.2.6-darwin-arm64.tar.gz"
      sha256 "27f880f135d79afee71fab32e1f330508522ec06185d6738c1d3e80dfb062099"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.6/ki-v0.2.6-darwin-x64.tar.gz"
      sha256 "dc897ac78b0b8ff61f51c9c603fe17eb1b1ea583983653d44d592f76826cdb61"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.6/ki-v0.2.6-linux-x64.tar.gz"
      sha256 "209570d427de7d002bac2919761d2ce6da4a561feb1f8766bcd0c0d06012e79c"
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
