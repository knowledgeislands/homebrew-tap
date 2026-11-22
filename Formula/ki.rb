class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.17.0/ki-v0.17.0-darwin-arm64.tar.gz"
      sha256 "ef24167c88650113834655b75990309a8a657ac19fea93dba8347ddd3c504146"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.17.0/ki-v0.17.0-darwin-x64.tar.gz"
      sha256 "3eb894cc5ed8e8c5dce284d40ed1cde2bac9cf0e82cc1f14edad4051ed058bdd"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.17.0/ki-v0.17.0-linux-x64.tar.gz"
      sha256 "e8c554bafb52aaa309e9884409566bf901b0d1891e8bc8c005cc686de5f7865d"
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
