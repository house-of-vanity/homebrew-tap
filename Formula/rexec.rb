class Rexec < Formula
  desc "Remote execution tool"
  homepage "https://github.com/house-of-vanity/rexec"
  version "1.5.2"
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/rexec/releases/download/v1.5.2/rexec_macos-arm64"
      sha256 "c906370b5f55ab423f148a43baf3bca12a5661ca90091ca3bbef44094c62c9f0"
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/house-of-vanity/rexec/releases/download/v1.5.2/rexec_linux-amd64"
      sha256 "4366515ee4465312def9e148787ec2e801fcdfc5487b70ae2b47454878a4f028"
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
