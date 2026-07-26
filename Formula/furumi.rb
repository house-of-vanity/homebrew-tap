class Furumi < Formula
  desc "Federated P2P player for personal music libraries"
  homepage "https://github.com/house-of-vanity/furumi_tui"
  version "0.1.6"
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/furumi_tui/releases/download/v0.1.6/furumi-macos-aarch64-0.1.6.tar.gz"
      # Replace after publishing the corrected v0.1.6 release asset.
      sha256 "6f2fe7de2fecc087bebfe6d594bff90d79f815e9fde018126e33c22f0a55f4da"
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  def install
    bin.install "furumi-macos-aarch64/furumi" => "furumi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/furumi --version")
  end
end
