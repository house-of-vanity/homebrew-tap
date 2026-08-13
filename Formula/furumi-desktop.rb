class FurumiDesktop < Formula
  VERSION = "0.1.1".freeze
  SHA256 = "e3eadd7ef1cac664d57d3ca476654f36726f51b26f80bcbb290053ee0523d676".freeze

  desc "Native federated player for personal music libraries"
  homepage "https://github.com/Furumi-stack/furumi-desktop"
  version VERSION
  license "WTFPL"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Furumi-stack/furumi-desktop/releases/download/v#{VERSION}/furumi-desktop-macos-aarch64-#{VERSION}.tar.gz"
      sha256 SHA256
    else
      odie "Intel macOS is not supported. Only ARM64 (Apple Silicon) is available."
    end
  end

  def install
    prefix.install "Furumi Desktop.app"
    launcher = bin/"furumi-desktop"
    launcher.write <<~SH
      #!/bin/bash
      exec /usr/bin/open "#{prefix}/Furumi Desktop.app" --args "$@"
    SH
    launcher.chmod 0755
  end

  def caveats
    <<~EOS
      Furumi Desktop was installed as an application bundle.

      Launch it with:
        furumi-desktop

      Or open it directly:
        open "#{opt_prefix}/Furumi Desktop.app"
    EOS
  end

  test do
    assert_predicate prefix/"Furumi Desktop.app/Contents/MacOS/furumi-desktop", :executable?
    plist = prefix/"Furumi Desktop.app/Contents/Info.plist"
    assert_match "cy.hexor.furumi-desktop",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' '#{plist}'")
  end
end
