cask "khm-desktop" do
  version "0.7.1"
  sha256 "d427a4bf289b383455fed375fd192a4c3539d5a1e17b690ee3826d3b893a1231"

  url "https://github.com/house-of-vanity/khm/releases/download/v#{version}/khm-desktop_macos-arm64"
  name "KHM Desktop"
  desc "SSH known hosts manager - Desktop version"
  homepage "https://github.com/house-of-vanity/khm"

  depends_on arch: :arm64

  # Install as executable binary
  binary "khm-desktop_macos-arm64", target: "khm-desktop"

  # Create app wrapper that launches with --settings-ui
  app_wrapper = "#{staged_path}/KHM Desktop.app"
  
  postflight do
    # Create .app bundle structure
    system_command "mkdir", args: ["-p", "#{app_wrapper}/Contents/MacOS"]
    
    # Create Info.plist
    info_plist = <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>khm-desktop-launcher</string>
        <key>CFBundleIdentifier</key>
        <string>net.houseofvanity.khm-desktop</string>
        <key>CFBundleName</key>
        <string>KHM Desktop</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
      </dict>
      </plist>
    PLIST
    
    File.write("#{app_wrapper}/Contents/Info.plist", info_plist)
    
    # Create launcher script
    launcher_script = <<~SCRIPT
      #!/bin/bash
      exec "#{HOMEBREW_PREFIX}/bin/khm-desktop" --settings-ui "$@"
    SCRIPT
    
    File.write("#{app_wrapper}/Contents/MacOS/khm-desktop-launcher", launcher_script)
    system_command "chmod", args: ["+x", "#{app_wrapper}/Contents/MacOS/khm-desktop-launcher"]
    
    # Move app to Applications
    system_command "cp", args: ["-R", app_wrapper, "/Applications/"]
  end

  uninstall delete: "/Applications/KHM Desktop.app"

  zap trash: [
    "~/Library/Preferences/khm-desktop.plist",
    "~/Library/Application Support/khm-desktop",
  ]
end