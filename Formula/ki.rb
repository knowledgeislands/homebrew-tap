class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  version "0.2.11"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.11/ki-v0.2.11-darwin-arm64.tar.gz"
      sha256 "409dc48d5105a8c2ff95b7f6c7acd5989a62eb1a4c672b50f17ab077f2d8cc0b"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.11/ki-v0.2.11-darwin-x64.tar.gz"
      sha256 "7460748918015213d9116faee6c9c8d8c62f5aa915239c9bfdeece75ee1983d1"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.11/ki-v0.2.11-linux-x64.tar.gz"
      sha256 "66807b0c92c5efa8c3c21d00ff3ced0490e7b5b5823821cb1d7ae304a3cabe08"
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
