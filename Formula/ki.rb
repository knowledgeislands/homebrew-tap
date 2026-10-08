class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.0/ki-v0.10.0-darwin-arm64.tar.gz"
      sha256 "f2c234cb6fe8b101d19f2af16908350157adee70fefb95a6acf9dc64ac6655b9"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.0/ki-v0.10.0-darwin-x64.tar.gz"
      sha256 "dd3dbc03412fef21e4aea1ca12b65fc6974583740e904beba0df8cba6ddd8ff2"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.0/ki-v0.10.0-linux-x64.tar.gz"
      sha256 "bd1558b47890457358c4529a55fe6ac0cdf252a9751ec5b7e98054c4bfe125dc"
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
