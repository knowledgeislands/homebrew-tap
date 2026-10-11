class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.1/ki-v0.10.1-darwin-arm64.tar.gz"
      sha256 "575a834c06799c0f07b48e5e1f089eff8d5c629e87a15718a83921428633082c"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.1/ki-v0.10.1-darwin-x64.tar.gz"
      sha256 "300c0cf1f07838b67b46b3acedf794c33e6c3f31ff3438780fa55f6f75136a93"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.1/ki-v0.10.1-linux-x64.tar.gz"
      sha256 "e77043ee229df0a2dc33d9ba69b0ce9b981bc8070eb448a7e639fec00095a378"
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
