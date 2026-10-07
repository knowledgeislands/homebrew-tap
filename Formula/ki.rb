class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.4/ki-v0.8.4-darwin-arm64.tar.gz"
      sha256 "eda5ea40d151c7f69f80ce85082b89e67016911f9847dcd8eb4a95bed435d76a"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.4/ki-v0.8.4-darwin-x64.tar.gz"
      sha256 "8f137b12077dafd85003307e621e7ea7e2156621bbb8660e7aecbe28ab0d0518"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.4/ki-v0.8.4-linux-x64.tar.gz"
      sha256 "4b8719b84e15e0879df41384124167a5f688ea75e06509a9e5fc3a7cd86544ec"
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
