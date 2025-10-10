cask "khm-desktop" do
  version "0.7.1"
  sha256 "d427a4bf289b383455fed375fd192a4c3539d5a1e17b690ee3826d3b893a1231"

  url "https://github.com/house-of-vanity/khm/releases/download/v#{version}/khm-desktop_macos-arm64"
  name "KHM Desktop"
  desc "SSH known hosts manager - Desktop version"
  homepage "https://github.com/house-of-vanity/khm"

  # Only supports Apple Silicon
  depends_on arch: :arm64

  # Create an app bundle for the binary
  app "khm-desktop_macos-arm64", target: "KHM Desktop.app"

  # Alternative: Install as binary in /Applications/Utilities/
  # binary "khm-desktop_macos-arm64", target: "khm-desktop"

  zap trash: [
    "~/Library/Preferences/khm-desktop.plist",
    "~/Library/Application Support/khm-desktop",
  ]
end