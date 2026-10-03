class Tsunagi < Formula
  VERSION = "0.1.0-rc.21"
  SHA256 = "eb6978c3a69ab0dcf184803df8eba98e0fecae29f18a6a37f506ada588500f07"

  desc "Peer-to-peer mesh network with no server (command line agent)"
  homepage "https://github.com/house-of-vanity/tsunagi"
  version VERSION
  license "WTFPL"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/house-of-vanity/tsunagi/releases/download/v#{VERSION}/tsunagi-macos-aarch64-#{VERSION}.tar.gz"
      sha256 SHA256
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  def install
    bin.install "tsng"
  end

  # The agent creates a utun interface and writes /etc/resolver, which only root
  # may do, so it runs as a system daemon: `sudo brew services start tsunagi`.
  # Its control socket is open to the admin group, which is what lets `tsng` and
  # the tray app manage it without sudo.
  service do
    run [opt_bin/"tsng", "up"]
    keep_alive true
    environment_variables TSUNAGI_CONTROL_GROUP: "admin"
    log_path var/"log/tsunagi.log"
    error_log_path var/"log/tsunagi.log"
  end

  def caveats
    <<~EOS
      The agent needs root, so start it as a system service (it then also starts at boot):

        sudo brew services start #{name}

      Administrators can then run `tsng` without sudo:

        tsng status
        tsng join --network <name>

      The tray app is a separate package: brew install --cask tsunagi-gui
    EOS
  end

  test do
    assert_match "tsng", shell_output("#{bin}/tsng --help")
  end
end
