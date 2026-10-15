class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.5/ki-v0.10.5-darwin-arm64.tar.gz"
      sha256 "86f2618ef1dc30083f5e803d20a5553f4a6570329ae1460260de49c3a384868a"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.5/ki-v0.10.5-darwin-x64.tar.gz"
      sha256 "9509f92ed21d723539f0ee587fffb8c88d4ccd7de5b13e4480e9e4d29c3a2fd7"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.5/ki-v0.10.5-linux-x64.tar.gz"
      sha256 "d1cf4f37d38bb7f2ee8b914cd6f29d6401d42d4d71c036968d9ebe67c31def60"
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
