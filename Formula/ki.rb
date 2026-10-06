class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.0/ki-v0.7.0-darwin-arm64.tar.gz"
      sha256 "d31a96f43b1b7084262d0f1bb837c1c529c5c3a8159c025618a964de32e6c5d8"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.0/ki-v0.7.0-darwin-x64.tar.gz"
      sha256 "b6e2ca17b9618be8c0abdede63488c83712e3611817cbb45792ae946a9693a56"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.7.0/ki-v0.7.0-linux-x64.tar.gz"
      sha256 "080ec9408c6a7c85c902a90920c4c3eb4e3dbfd415c1e359976e64b7b5a962e7"
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
