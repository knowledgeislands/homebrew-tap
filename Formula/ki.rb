class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.3/ki-v0.11.3-darwin-arm64.tar.gz"
      sha256 "f5167f7416b87ab103788f38cea3cdd46c5abda47c482202f477be721f6a5917"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.3/ki-v0.11.3-darwin-x64.tar.gz"
      sha256 "3eb0c2008380da7a5a06720f1d2f022cb3acac7d603f3eece365a557f6950742"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.11.3/ki-v0.11.3-linux-x64.tar.gz"
      sha256 "19c487290f123be498977451f2b869d5b3aa81cafd34dbfa6552dc08e175f8af"
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
