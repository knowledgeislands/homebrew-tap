class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.4/ki-v0.10.4-darwin-arm64.tar.gz"
      sha256 "ac93afc48014f3bbbe52066b511aaf335f68186ca6c60ffb8d47f55c20d610ee"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.4/ki-v0.10.4-darwin-x64.tar.gz"
      sha256 "c30532accde5a7838e83cf07426a4fda3e4c0f00b7882ab61b00c26520805740"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.4/ki-v0.10.4-linux-x64.tar.gz"
      sha256 "8afeb7f28f5df5da7c4b3d6018ce4a6abb2fb92b19e0dbff7349a47193ae1d39"
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
