class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.4/ki-v0.11.4-darwin-arm64.tar.gz"
      sha256 "04aaa8c2081198441c3459e70980203bb6e939189ea05fd8a502b2524a6aaa11"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.4/ki-v0.11.4-darwin-x64.tar.gz"
      sha256 "e5b4d8a48ba229c1bb38219a6eb9a23081a29c8c4d61b8460b87898ce0e07164"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.4/ki-v0.11.4-linux-x64.tar.gz"
      sha256 "3b28f0868e1f15f398d1d9e44d5006f05a3360b9db761d9979e85609a06e7b46"
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
