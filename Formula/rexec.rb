class Rexec < Formula
  desc "Remote execution tool"
  homepage "https://github.com/house-of-vanity/rexec"
  version "1.5.1"
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/rexec/releases/download/v1.5.1/rexec_macos-arm64"
      sha256 "f5d54932644ba30c368d4c3b343da997b93f868e8603a10751274fb317c4a814"
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/house-of-vanity/rexec/releases/download/v1.5.1/rexec_linux-amd64"
      sha256 "d6e473f81c18b99b358c760483e0bedc55e192b594c71d3b9df5bde63df19895"
    else
      odie "Only Linux AMD64 is supported."
    end
  end

  def install
    bin.install "rexec_macos-arm64" => "rexec" if OS.mac?
    bin.install "rexec_linux-amd64" => "rexec" if OS.linux?
  end

  test do
    system "#{bin}/rexec", "--version"
  end
end
