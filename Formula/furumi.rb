class Furumi < Formula
  VERSION = "0.3.5"
  SHA256 = "5c42ddcc617c50f496b830c0ad1aa89bed3344f282c4acaa649818b1b5caf7fe"

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
