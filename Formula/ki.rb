class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.0/ki-v0.5.0-darwin-arm64.tar.gz"
      sha256 "a22df1ac113b8538d0735d3b23fd844f774905d3f643f7c99f61b8a98277a96e"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.0/ki-v0.5.0-darwin-x64.tar.gz"
      sha256 "a7380e09ed1e6f3f44148d855e686c5302132c6d25efa0ade0fd4ba5eb41cdcb"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.5.0/ki-v0.5.0-linux-x64.tar.gz"
      sha256 "dace4d3c36dec67b53ca1a6dd9df9c5462be712896438f2e315c411407c5f324"
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
