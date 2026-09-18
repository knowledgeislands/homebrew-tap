class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-arm64.tar.gz"
      sha256 "5583aa229c4558c1e42f2edf0076ba68df2192eac25f44715fe68f3c7d44786b"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-darwin-x64.tar.gz"
      sha256 "1abe99523d0fe4be5872273ae36ca0cbbdd8abebf2880f7c855a7b049efc711b"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.4.0/ki-v0.4.0-linux-x64.tar.gz"
      sha256 "c27341fc34144009b5941becc7cebbd0b795be7897689506f1ef49996226d460"
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
