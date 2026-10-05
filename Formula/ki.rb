class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.0/ki-v0.6.0-darwin-arm64.tar.gz"
      sha256 "50328303af0c0fab9a632fc5cc6aea6a78a3ac34d7023f54729f1e38464ad515"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.0/ki-v0.6.0-darwin-x64.tar.gz"
      sha256 "fe19720d2d937d05e8454c2f575fe536ca7d91174ca0bf4a0736d64bedb63525"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.6.0/ki-v0.6.0-linux-x64.tar.gz"
      sha256 "170c47636824de233a32324d923608b9acefc43f534a3681724f0ebb56a4662e"
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
