class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.3/ki-v0.8.3-darwin-arm64.tar.gz"
      sha256 "7ea719f642f02f761ce35cddbee93b969ed4325eb1f7736326bc0a3b15e2c41d"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.3/ki-v0.8.3-darwin-x64.tar.gz"
      sha256 "0bb1d0b7bc6114b8bcc70dcd2add7f9efe9f1e02bb0305d95085d5485a9d997d"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.8.3/ki-v0.8.3-linux-x64.tar.gz"
      sha256 "33e8e2f60b77e2d767bb3e9034747fdbbecccf8d72aaa195309d7346932ea9ad"
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
