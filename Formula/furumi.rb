class Furumi < Formula
  desc "Federated P2P player for personal music libraries"
  homepage "https://github.com/house-of-vanity/furumi_tui"
  version "0.1.8"
  sha256 "f8be8cd1aea57ac6e4043397d6cff1a9030df10af7d84f9570d6763b244428f5"
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/furumi_tui/releases/download/v#{version}/furumi-macos-aarch64-#{version}.tar.gz"
      sha256 "#{sha256}"
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
