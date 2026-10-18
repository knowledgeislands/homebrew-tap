class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.1/ki-v0.11.1-darwin-arm64.tar.gz"
      sha256 "2bbe6078b220cfa45c7c3ef00bb302721660f8a3b3ee06cba71de9332f0686d8"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.1/ki-v0.11.1-darwin-x64.tar.gz"
      sha256 "db6b0a59ccde4cf6fd6ad89f427050226bb26de87e6a400c57b50b8b133fe522"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.1/ki-v0.11.1-linux-x64.tar.gz"
      sha256 "b007a3011452fba16d3b8841a4f1092798d385044bf1beedef1aefbc2c0fa425"
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
