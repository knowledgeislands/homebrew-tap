class Techne < Formula
  desc "Operator command-line interface for the Techne Harness"
  homepage "https://github.com/knowledgeislands/tools-techne"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.0/techne-v0.1.0-darwin-arm64.tar.gz"
      sha256 "6e0d4cdc90d4f38ce369be8c91400979b1b0464f62248640415e7bdf9f5b905b"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.0/techne-v0.1.0-darwin-x64.tar.gz"
      sha256 "a6bdfb85c557c4d02baa1f04e2ca5016ff001646d8e61dfb784b5c8cfe7d2198"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.0/techne-v0.1.0-linux-x64.tar.gz"
      sha256 "9f139ad1ed5666ce8f194179f6457826bbb70fc27b92023939d18eca0d53f724"
    end
  end

  def install
    bin.install "techne"
    man1.install "man/techne.1"
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/techne --version")
    assert_match '"installation":"release"', shell_output("#{bin}/techne diag --json")
  end
end
