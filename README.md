# homebrew-tap

Personal Homebrew tap for custom formulas.

## Installation

```bash
# Add the tap repo
brew tap house-of-vanity/tap

# Install apps
brew install rexec
```

## Available packages

- **rexec** - Remote execution tool
- **tmux-helper** - Tmux status helper
- **khm** - SSH known hosts manager
- **furumi** - Federated P2P player for personal music libraries (Apple Silicon)
- **furumi-desktop** (Cask) - Native graphical Furumi player (Apple Silicon)
- **tsunagi** - Peer-to-peer mesh network with no server, command line agent (Apple Silicon)
- **tsunagi-gui** (Cask) - Tray app for tsunagi; installs the agent and starts it as a service (Apple Silicon)

## Direct installation

```bash
brew install house-of-vanity/tap/rexec
brew install house-of-vanity/tap/furumi
brew install --cask house-of-vanity/tap/furumi-desktop
brew install --cask house-of-vanity/tap/tsunagi-gui   # tray app + agent, started for you
brew install house-of-vanity/tap/tsunagi              # command line agent only
sudo brew services start tsunagi                      # ...which you start yourself
```

## Bumping tsunagi

`scripts/bump-tsunagi.sh <version>` fetches the release archive and rewrites the
version and checksum of both the formula and the cask, which share it.
