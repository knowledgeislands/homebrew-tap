class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.5/ki-v0.11.5-darwin-arm64.tar.gz"
      sha256 "21e3a045fc576713b75fc23ab928f729799f2287d560b8e3e2be0637cf6298f3"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.5/ki-v0.11.5-darwin-x64.tar.gz"
      sha256 "79a690b0bbc4fabf6f28de38c9ec6af1bd0f6052a0bc6555f9dca42a876e66da"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.5/ki-v0.11.5-linux-x64.tar.gz"
      sha256 "470f05adf4c5e346abd05b4f5c156fe4267aef02a8cf5d65641e5eac0ced9470"
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
