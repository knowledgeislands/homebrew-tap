class Ki < Formula
  desc "Knowledge Islands command-line interface"
  homepage "https://github.com/knowledgeislands/tools-ki"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.12.0/ki-v0.12.0-darwin-arm64.tar.gz"
      sha256 "64ad69301a503588e6a14537a4675333cdf83a2ac7ef39b3a7b5f022dc796925"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.12.0/ki-v0.12.0-darwin-x64.tar.gz"
      sha256 "a6b6e6def44ab84f49e2c974f20a69388029ca4930921585b9d489f93c32899a"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-ki/releases/download/v0.12.0/ki-v0.12.0-linux-x64.tar.gz"
      sha256 "43407b845e777e2df669d5d155a540ec8e45a7989658910276f8668508358e91"
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
