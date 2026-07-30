class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.13/ki-v0.2.13-darwin-arm64.tar.gz"
      sha256 "8ccea8f5c6c51f9902877e8a4e3b976b1c84e3fb4f06f241be16ad485cf5a539"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.13/ki-v0.2.13-darwin-x64.tar.gz"
      sha256 "aaabc582ea55345bed40377286c83bf116742d433ca14d6d99037293ddb258db"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.2.13/ki-v0.2.13-linux-x64.tar.gz"
      sha256 "1ba94fd00c8e7b13968d1bc08ed4e4dbbfd5543fc812d578e95aa2baaedd3fa4"
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
