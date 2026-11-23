cask "tsunagi-gui" do
  version "1.0.0"
  sha256 "fd115ee1a47f1263c9ab772cd7466fa13ff2f7ec4978c5b25708f7a05f7a12f7"

  url "https://github.com/house-of-vanity/tsunagi/releases/download/v#{version}/tsunagi-macos-aarch64-#{version}.tar.gz"
  name "Tsunagi"
  desc "Tray app for the tsunagi peer-to-peer mesh network"
  homepage "https://github.com/house-of-vanity/tsunagi"

  depends_on arch: :arm64
  depends_on macos: :big_sur
  # The agent the tray talks to.
  depends_on formula: "house-of-vanity/tap/tsunagi"

  app "tsunagi-macos-aarch64/Tsunagi.app"

  postflight_steps do
    # Not notarised, so a download carries a quarantine flag that would stop it.
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tsunagi.app"]

    # The agent runs as a root daemon, which asks for the password once. Left
    # to the caveat below if it does not take.
    run HOMEBREW_BREW_FILE,
        args:         ["services", "start", "tsunagi"],
        sudo:         true,
        must_succeed: false
  end

  uninstall quit: "cy.hexor.tsunagi.tray"

  caveats <<~EOS
    The tray app talks to the tsunagi agent, which runs as a root service. If it
    is not running, start it (and have it start at boot) with:

      sudo brew services start tsunagi

    Administrators can use the tray and `tsng` without sudo.
  EOS
end
