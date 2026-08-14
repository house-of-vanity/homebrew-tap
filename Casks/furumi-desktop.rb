cask "furumi-desktop" do
  version "0.1.2"
  sha256 "3e48d5b5d6d221ef61f667ebaae06ae77e6e7d85109e2f87244eac4b37c2b30c"

  url "https://github.com/Furumi-stack/furumi-desktop/releases/download/v#{version}/furumi-desktop-macos-aarch64-#{version}.tar.gz"
  name "Furumi Desktop"
  desc "Native federated player for personal music libraries"
  homepage "https://github.com/Furumi-stack/furumi-desktop"

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "furumi-desktop-macos-aarch64/Furumi Desktop.app"

  zap trash: [
    "~/Library/Application Support/cy.hexor.Furumi",
    "~/Library/Caches/cy.hexor.Furumi",
    "~/Library/Preferences/cy.hexor.furumi-desktop.plist",
  ]
end
