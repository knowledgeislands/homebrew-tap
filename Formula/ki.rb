class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.1/ki-v0.16.1-darwin-arm64.tar.gz"
      sha256 "dd9dc0d8ba0e26903abc5ccdba6fb16a747ce20e9d58e2d87c5d57043971e138"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.1/ki-v0.16.1-darwin-x64.tar.gz"
      sha256 "907e73f325d2d7dd027e6eae5db4da58398a998e5ac0153489e9fe3764eb88f2"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.1/ki-v0.16.1-linux-x64.tar.gz"
      sha256 "72f809f022f7bb68f6041d1328116f8bf728cb1cb5c7209cfdd762db9e8b4ab3"
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
