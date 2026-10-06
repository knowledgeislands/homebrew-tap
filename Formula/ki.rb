class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.1/ki-v0.6.1-darwin-arm64.tar.gz"
      sha256 "93110bd03d8db48da4013d5967d9dde9480938a0cd5a58aa523ce3991c0af79c"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.1/ki-v0.6.1-darwin-x64.tar.gz"
      sha256 "3f05c51d8c507b773d9858db9b11e6bba036840aa608675752915c1a589679cf"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.1/ki-v0.6.1-linux-x64.tar.gz"
      sha256 "f2a8ac8847c164ba521ac672062230111cf902ade38cbd3dd13cec8ef46f8cca"
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
