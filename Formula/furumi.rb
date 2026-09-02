class Furumi < Formula
  VERSION = "0.2.8"
  SHA256 = "7a583c8c210bf8f813d1b8a5254fc5feabb8f06f501233fa3e8e63b83c07aadf"

  desc "Federated P2P player for personal music libraries"
  homepage "https://github.com/house-of-vanity/furumi_tui"
  version VERSION
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Furumi-stack/furumi-tui/releases/download/v#{VERSION}/furumi-macos-aarch64-#{VERSION}.tar.gz"
      sha256 SHA256
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  def install
    bin.install "furumi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/furumi --version")
  end
end
