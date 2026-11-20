class Furumi < Formula
  VERSION = "0.5.0"
  SHA256 = "0f7932bfa9f5759889a5b118ee66e546815fe3cc5ac8116cb12325e32b977494"

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
