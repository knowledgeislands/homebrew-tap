class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.9.0/ki-v0.9.0-darwin-arm64.tar.gz"
      sha256 "90fa4bb5795e0cd6ce347478d34cccae29921162013db6990d6d15080c5935ad"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.9.0/ki-v0.9.0-darwin-x64.tar.gz"
      sha256 "82e041e40dd153161249941e99174ef7095a305ba67a157c8bcf9bcafb3fa9a3"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.9.0/ki-v0.9.0-linux-x64.tar.gz"
      sha256 "ec981f962ffb1484c1ba68aeba572f3f7b589b9a345da07f1a86fb91571c96d6"
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
