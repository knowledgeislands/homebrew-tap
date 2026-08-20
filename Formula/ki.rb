class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.3.3/ki-v0.3.3-darwin-arm64.tar.gz"
      sha256 "efd5a100ee39bdec995bf32bc4117060c1ae9a9ea62450a2fad8d0e5fb103644"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.3.3/ki-v0.3.3-darwin-x64.tar.gz"
      sha256 "117331b07b1568289dae2b2fc56a942192ac03c759a238a3be66783ab2988b51"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.3.3/ki-v0.3.3-linux-x64.tar.gz"
      sha256 "53eca561fd221dc203469093e004fd45e2b606104d8d0a969e950ea3f87872c0"
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
