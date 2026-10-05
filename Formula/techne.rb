class Techne < Formula
  desc "Operator command-line interface for the Techne Harness"
  homepage "https://github.com/knowledgeislands/tools-techne"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.2.0/techne-v0.2.0-darwin-arm64.tar.gz"
      sha256 "0cc49516ea273aaa485fc327d2f3ce7d7ed48d236ca9021d1a1a9d207d84710f"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.2.0/techne-v0.2.0-darwin-x64.tar.gz"
      sha256 "7a636c1f1f185da69c142cab866e1121254fcb7fe548809b40af7e184b53a079"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.2.0/techne-v0.2.0-linux-x64.tar.gz"
      sha256 "2865202472fe645deae268c6574b7069b6ce5952313619e3574a133aa3cb89b4"
    end
  end

  def install
    bin.install "techne"
    man1.install "man/techne.1"
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/techne --version")
    assert_match '"installation":"release"', shell_output("#{bin}/techne diag --json")
    assert_match "complete -F _techne techne", shell_output("#{bin}/techne completion bash")
    assert_match "#compdef techne", shell_output("#{bin}/techne completion zsh")
  end
end
