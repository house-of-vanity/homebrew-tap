class Furumi < Formula
  VERSION = "0.2.3"
  SHA256 = "e9f2c4f0f872df40d90ee00eb9c1ff1d9e323cf3d18814bc7ea7bc7edc4aa330"

  desc "Federated P2P player for personal music libraries"
  homepage "https://github.com/house-of-vanity/furumi_tui"
  version VERSION
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/furumi_tui/releases/download/v#{VERSION}/furumi-macos-aarch64-#{VERSION}.tar.gz"
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
