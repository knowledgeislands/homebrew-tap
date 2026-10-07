class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.0/ki-v0.8.0-darwin-arm64.tar.gz"
      sha256 "99041790a3bf5e0ae72ed1042cd6cf361705bb15a1f8c513a0b913a0a4d68a7e"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.0/ki-v0.8.0-darwin-x64.tar.gz"
      sha256 "1e7b4abebc0119cf6ccfb40fc8ca67c00d83328d7de6646786c31f4ef630a727"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.0/ki-v0.8.0-linux-x64.tar.gz"
      sha256 "397a8208279555b2aabe7c8dbf4a998a4a847a14d9010c360b3c6c95a5f8dde1"
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
