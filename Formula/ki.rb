class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.2/ki-v0.8.2-darwin-arm64.tar.gz"
      sha256 "b419444cbcdd2ada4862f76e3ac9b2f640ec552cd542653f60190705c370e92b"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.2/ki-v0.8.2-darwin-x64.tar.gz"
      sha256 "d5063d6840b2dfeac0c821b8464111d51e3389cd209d28a6fc52c72e01853364"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.2/ki-v0.8.2-linux-x64.tar.gz"
      sha256 "a525b9b3d5c6960106547e85e420f8f17e00405bede95825491f82e0ce428592"
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
