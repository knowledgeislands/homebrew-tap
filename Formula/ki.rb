class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.2/ki-v0.10.2-darwin-arm64.tar.gz"
      sha256 "d58db2a794be9ad3b07bcd35d978ce5afe531c2e950bafaadb518bb696d398bf"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.2/ki-v0.10.2-darwin-x64.tar.gz"
      sha256 "eba933d8f47343c1db8090f55f2efd16ff7846c6ca43a84cfb557ed9b96b3ebd"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.10.2/ki-v0.10.2-linux-x64.tar.gz"
      sha256 "afbef916b2576303985ad64fd80adde4200a8902f195349cb72ea39c70f3b619"
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
