class Mgit < Formula
  desc "Run a git command across many repositories at once"
  homepage "https://github.com/knowledgeislands/tools-mgit"
  url "https://github.com/knowledgeislands/tools-mgit/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "9758ee0210bbe3b820400f0a71b826f60c13cdc8fe76a0b183dd845a49f3106c"
  license "MIT"

  def install
    bin.install "bin/mgit"
  end

  test do
    assert_match "mgit #{version}", shell_output("#{bin}/mgit --version")
    assert_match "Usage: mgit", shell_output("#{bin}/mgit --help")
  end
end
