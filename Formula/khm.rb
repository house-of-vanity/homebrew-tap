class Khm < Formula
  desc "Keyboard and mouse sharing tool"
  homepage "https://github.com/house-of-vanity/khm"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/khm/releases/download/v0.7.1/khm_macos-arm64"
      sha256 "529f5e878b652434a4ba520ef1aabde093a50da5e1d67714c44a85394e4a693a"
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/house-of-vanity/khm/releases/download/v0.7.1/khm_linux-amd64"
      sha256 "e1141332f1c0f96c9800c18d9af031f902f8fdbe0f796c763b6adc08d5b1db07"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/house-of-vanity/khm/releases/download/v0.7.1/khm_linux-arm64"
      sha256 "bf46d74baebd96acb7def8bda824039e075bdbc916ea8911296e7ed52fc97b58"
    else
      odie "Only Linux AMD64 and ARM64 are supported."
    end
  end

  def install
    if OS.mac?
      bin.install "khm_macos-arm64" => "khm"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "khm_linux-amd64" => "khm"
    else
      bin.install "khm_linux-arm64" => "khm"
    end
  end

  def caveats
    <<~EOS
      khm is a keyboard and mouse sharing tool.
      
      Note: There's also a desktop version (khm-desktop) available 
      with GUI, but it's not included in this formula.
    EOS
  end

  test do
    system "#{bin}/khm", "--version"
  end
end