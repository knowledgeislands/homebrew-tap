class Techne < Formula
  desc "Operator command-line interface for the Techne Harness"
  homepage "https://github.com/knowledgeislands/tools-techne"
  license "MIT"

  on_arm do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.1/techne-v0.1.1-darwin-arm64.tar.gz"
      sha256 "801ca00678185f8134a0d5f4feb652fae7f49a2f6d239f03e0410c1143de4b45"
    end
  end

  on_intel do
    on_macos do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.1/techne-v0.1.1-darwin-x64.tar.gz"
      sha256 "b9e8c99ac525ac6e8b218063403e4c9b074bfd5a756d44bfa1ae85b9c316a059"
    end

    on_linux do
      url "https://github.com/knowledgeislands/tools-techne/releases/download/v0.1.1/techne-v0.1.1-linux-x64.tar.gz"
      sha256 "ca368e4d2e91e8dd19bfc938fa22fa2bc4127658a288f792b8bec47df7d4d8c2"
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
