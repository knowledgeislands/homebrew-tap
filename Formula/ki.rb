class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.19/ki-v0.2.19-darwin-arm64.tar.gz"
      sha256 "3468eda1852cd6ad7f8dc149ba819c545cafb874d0e32e6a926b235db488430c"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.19/ki-v0.2.19-darwin-x64.tar.gz"
      sha256 "927ba23abbe229c5821831c9ff5c42af8b9ea27e60f67b477d1ca63334991394"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.19/ki-v0.2.19-linux-x64.tar.gz"
      sha256 "48ab70185d1d9e693fd4ca2877488ce2a40125f5fbd738949967a13d87bcd51a"
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
