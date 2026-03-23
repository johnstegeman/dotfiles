# macOS Applications

Applications installed via Homebrew casks, managed through `~/config/Brewfile`. Install all of them with `br in`.

## Productivity & Utilities

| App | Description |
|-----|-------------|
| [Raycast](https://www.raycast.com/) | Launcher and productivity tool — replaces Spotlight |
| [Maccy](https://maccy.app/) | Clipboard manager — remembers clipboard history and lets you paste any prior entry |
| [Bartender](https://www.macbartender.com/) | Hides and organizes menu bar icons (useful on MacBooks with the camera notch) |
| [SizeUp](https://www.irradiatedsoftware.com/sizeup/) | Window management with keyboard shortcuts |
| [Shottr](https://shottr.cc/) | Screenshot utility with annotation tools |
| [Zappy](https://zapier.com/zappy) | Screenshot and animated GIF capture |
| [Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html) | Configuration for Logitech peripherals |

## Communication & Calendar

| App | Description |
|-----|-------------|
| [Slack](https://slack.com/) | Team messaging |
| [Webex](https://www.webex.com/) | Video conferencing |
| [Notion](https://www.notion.so/) | Notes and docs |
| [Notion Calendar](https://www.notion.so/product/calendar) | Calendar app with Google Calendar integration — shows upcoming meetings in menu bar |
| [Notion Mail](https://www.notion.so/product/mail) | Email client integrated with Notion |
| [Asana](https://asana.com/) | Project management |

## Development

| App | Description |
|-----|-------------|
| [Orbstack](https://orbstack.dev/) | Fast, lightweight Docker and Linux VM manager (Docker Desktop replacement) |
| [IntelliJ IDEA](https://www.jetbrains.com/idea/) | JetBrains IDE for Java/Kotlin |
| [PyCharm](https://www.jetbrains.com/pycharm/) | JetBrains IDE for Python |
| [RustRover](https://www.jetbrains.com/rust/) | JetBrains IDE for Rust |
| [WebStorm](https://www.jetbrains.com/webstorm/) | JetBrains IDE for JavaScript/TypeScript |
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor (Rosé Pine theme) |
| [Zed](https://zed.dev/) | Fast, modern code editor — used by `cm ed` to open dotfiles |
| [Neo4j Desktop](https://neo4j.com/download/) | GUI for managing local Neo4j graph database instances |
| [Google Cloud CLI](https://cloud.google.com/sdk/gcloud) | CLI tools for Google Cloud Platform |
| [Wezterm](https://wezfurlong.org/wezterm/) | GPU-accelerated terminal emulator (primary) |
| [Ghostty](https://ghostty.org/) | Fast terminal emulator (alternative) |
| [Karabiner Elements](https://karabiner-elements.pqrs.org/) | Keyboard customization — used alongside Kanata |
| [Keymapp](https://www.zsa.io/keymapp/) | ZSA keyboard configurator |

## AI

| App | Description |
|-----|-------------|
| [Claude](https://claude.ai/download) | Anthropic's Claude desktop app |
| [Claude Code](https://claude.ai/claude-code) | Claude Code CLI |
| [Antigravity](https://antigravity.dev/) | AI coding assistant |
| [Cmux](https://github.com/nicholasgasior/cmux) | AI terminal assistant |

## Security & Storage

| App | Description |
|-----|-------------|
| [1Password](https://1password.com/) | Password manager |
| [1Password CLI](https://developer.1password.com/docs/cli/) | CLI integration (required for chezmoi secrets) |
| [Google Drive](https://www.google.com/drive/) | Cloud storage sync |
| [Microsoft AutoUpdate](https://docs.microsoft.com/en-us/deployoffice/mac/update-office-for-mac-using-msupdate) | Keeps Microsoft apps up to date |

## Creative

| App | Description |
|-----|-------------|
| [Affinity](https://affinity.serif.com/) | Affinity suite (Designer, Photo, Publisher) |
| [GIMP](https://www.gimp.org/) | Open source image editor |
| [Minecraft](https://www.minecraft.net/) | Minecraft |

## Fonts

| Font | Description |
|------|-------------|
| Maple Mono NF | Coding font with Nerd Font icons |
| Meslo LG Nerd Font | Nerd Font patched Meslo for Powerline/icon support |
| Monaspace NF | GitHub's Monaspace family with Nerd Font icons |

## Mac App Store

| App | Description |
|-----|-------------|
| DaVinci Resolve | Professional video editing |

## Homebrew Brewfile

The full Brewfile is at `~/config/Brewfile`. It installs both casks (GUI apps, above) and formulae (CLI tools — see [utilities.md](utilities.md)).

```fish
br in      # install everything in the Brewfile
br up      # update Homebrew and upgrade all installed packages
br clean   # remove anything installed that isn't in the Brewfile
```
