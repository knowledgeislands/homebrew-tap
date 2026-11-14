class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.0/ki-v0.16.0-darwin-arm64.tar.gz"
      sha256 "dd391be490bf9fb5b95b5576dcd58a6a7c91217b0986485b8d5267d062d973be"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.0/ki-v0.16.0-darwin-x64.tar.gz"
      sha256 "02fa27aa5dfcac3bf1fe3fc393c70c68d375a476df12562181d204cce78bf93c"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.16.0/ki-v0.16.0-linux-x64.tar.gz"
      sha256 "95ddcf969affdadfda4f88acbaec876b81f25d0cf18a82ca46d9918148459fd0"
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
