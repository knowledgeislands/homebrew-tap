class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.1/ki-v0.5.1-darwin-arm64.tar.gz"
      sha256 "e05692ead73abd94e7822b00bfedd8c07445b335f11a370f6fadd2a9eb8487bf"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.1/ki-v0.5.1-darwin-x64.tar.gz"
      sha256 "e7401483f57ab25de404b75e74521b82cc6f174cf0e92d5e345452aa0ce57299"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.1/ki-v0.5.1-linux-x64.tar.gz"
      sha256 "1a1379b8cbc2e3eab1a382c9a3bf3156b4d93afffe160d46ddfa49c5d743f90d"
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
