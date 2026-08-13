cask "furumi-desktop" do
  version "0.1.1"
  sha256 "e3eadd7ef1cac664d57d3ca476654f36726f51b26f80bcbb290053ee0523d676"

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
