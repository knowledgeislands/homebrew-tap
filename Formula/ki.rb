class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.3/ki-v0.10.3-darwin-arm64.tar.gz"
      sha256 "cffca26d1f5f411a5cfb25e28d88dcec3cfa3a5f5d67141cb30a5269577d16d3"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.3/ki-v0.10.3-darwin-x64.tar.gz"
      sha256 "01f8fd0d291248edefd576553e64e66906b82a27a8f92fef95ac19536f38322a"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.3/ki-v0.10.3-linux-x64.tar.gz"
      sha256 "b5e6a9aac45eba3a6bcaf350f92b7bacf4d0cf4366df9914d6c3a971dcedda56"
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
