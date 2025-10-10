class TmuxHelper < Formula
  desc "Tmux session management helper"
  homepage "https://github.com/house-of-vanity/tmux-helper"
  version "0.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/tmux-helper/releases/download/v0.5.1/tmux-helper_macos-arm64"
      sha256 "bc428e49c9427166a65550ed16889a25893d6c256c871338eb5e688a4bcb3f40"
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/house-of-vanity/tmux-helper/releases/download/v0.5.1/tmux-helper_linux-amd64"
      sha256 "3d04d3bcbad6a2940da4f58ec4dc8c02d99c876bac8586bcb7ad06340740e6d1"
    else
      odie "Only Linux AMD64 is supported."
    end
  end

  depends_on "tmux"

  def install
    if OS.mac?
      bin.install "tmux-helper_macos-arm64" => "tmux-helper"
    else
      bin.install "tmux-helper_linux-amd64" => "tmux-helper"
    end
  end

  test do
    system "#{bin}/tmux-helper", "--version"
  end
end