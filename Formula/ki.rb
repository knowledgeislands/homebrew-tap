class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.13.0/ki-v0.13.0-darwin-arm64.tar.gz"
      sha256 "37f3c17bcc5dd38be3a875d962770d1b28ad4c7b3ae858f1889b4e835f8d2186"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.13.0/ki-v0.13.0-darwin-x64.tar.gz"
      sha256 "c363683c6a8ff613a2a6b94cb79f47c5e8013778994d69f5394b54d4fd263732"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.13.0/ki-v0.13.0-linux-x64.tar.gz"
      sha256 "2a3be80cf491db9482d84b5993be4b279987482d4fc30c6bcfdf5b8737033d2a"
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
