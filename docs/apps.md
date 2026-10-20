# macOS Applications

GUI applications come from Homebrew casks, tracked in `brew/Brewfile.macos` (and
`brew/Brewfile.ai` for the AI clients). This page is the same list with a word about each —
if the two disagree, the Brewfile wins. The `Cask` column is the exact name to paste into a
`brew` command.

Install everything tracked with:

```fish
br in      # haven apply — files, casks and formulae
```

## Productivity and Utilities

| App | Cask | Description |
|-----|------|-------------|
| [Asana](https://asana.com/) | `asana` | Project management |
| [Canva](https://www.canva.com/) | `canva` | Design tool |
| [Gemini](https://gemini.google.com/) | `google-gemini` | Google's AI assistant, as a desktop app |
| [Grammarly Desktop](https://www.grammarly.com/desktop) | `grammarly-desktop` | Writing assistant |
| [Granola](https://www.granola.ai/) | `granola` | AI meeting notes |
| [IINA](https://iina.io/) | `iina` | Video player |
| [Keymapp](https://www.zsa.io/keymapp/) | `keymapp` | ZSA keyboard configurator (Moonlander, Voyager) |
| [Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html) | `logi-options+` | Logitech peripheral configuration |
| [Microsoft AutoUpdate](https://docs.microsoft.com/en-us/deployoffice/mac/update-office-for-mac-using-msupdate) | `microsoft-auto-update` | Keeps Microsoft apps current |
| [SizeUp](https://www.irradiatedsoftware.com/sizeup/) | `sizeup` | Window management with keyboard shortcuts |
| [Vorssaint](https://github.com/vorssaint/vorssaint-utils) | `vorssaint` | Menu bar toolkit: keep-awake, system monitor, volume mixer |

## Browsers

| App | Cask | Description |
|-----|------|-------------|
| [Dia](https://www.diabrowser.com/) | `thebrowsercompany-dia` | Browser from The Browser Company |

## Communication and Calendar

| App | Cask | Description |
|-----|------|-------------|
| [Slack](https://slack.com/) | `slack` | Team messaging |
| [Webex](https://www.webex.com/) | `webex` | Video conferencing |
| [Notion Calendar](https://www.notion.so/product/calendar) | `notion-calendar` | Calendar with Google Calendar integration |
| [Notion Mail](https://www.notion.so/product/mail) | `notion-mail` | Email client integrated with Notion |

## Development

| App | Cask | Description |
|-----|------|-------------|
| [Orbstack](https://orbstack.dev/) | `orbstack` | Docker and Linux VM manager (Docker Desktop replacement) |
| [IntelliJ IDEA](https://www.jetbrains.com/idea/) | `intellij-idea` | JetBrains IDE for Java and Kotlin |
| [PyCharm](https://www.jetbrains.com/pycharm/) | `pycharm` | JetBrains IDE for Python |
| [RustRover](https://www.jetbrains.com/rust/) | `rustrover` | JetBrains IDE for Rust |
| [WebStorm](https://www.jetbrains.com/webstorm/) | `webstorm` | JetBrains IDE for JavaScript and TypeScript |
| [Visual Studio Code](https://code.visualstudio.com/) | `visual-studio-code` | Editor — Ayu Dark via the `teabyii.ayu` extension; settings tracked as a symlinked `settings.json` |
| [Zed](https://zed.dev/) | `zed` | Fast editor; what `hv ed` opens the haven source in |
| [Neo4j Desktop](https://neo4j.com/download/) | `neo4j-desktop` | GUI for local Neo4j instances |
| [Karabiner Elements](https://karabiner-elements.pqrs.org/) | `karabiner-elements` | Lower-level keyboard remapping, alongside Kanata |
| [Ghostty](https://ghostty.org/) | `ghostty` | Terminal — the primary one |
| [Wezterm](https://wezfurlong.org/wezterm/) | `wezterm` | Terminal — alternative, config tracked, not currently installed |
| [Orca](https://github.com/stablyai/orca) | `stablyai/orca/orca` | Agent worktrees, terminals and runtimes |

## AI

| App | Cask | Description |
|-----|------|-------------|
| [Claude](https://claude.ai/download) | `claude` | Anthropic's Claude desktop app |
| [Antigravity CLI](https://antigravity.dev/) | `antigravity-cli` | AI coding assistant CLI |

Claude Code, Codex, opencode, and pi are installed through mise (`mise/mise.ai.toml`), not
as casks.

## Security and Storage

| App | Cask | Description |
|-----|------|-------------|
| [1Password](https://1password.com/) | `1password` | Password manager; supplies secrets through its SSH agent and CLI |
| [Google Drive](https://www.google.com/drive/) | `google-drive` | Cloud storage sync |

## Creative

| App | Cask | Description |
|-----|------|-------------|
| [Affinity](https://affinity.serif.com/) | `affinity` | Designer, Photo, Publisher |
| [GIMP](https://www.gimp.org/) | `gimp` | Open source image editor |
| [Minecraft](https://www.minecraft.net/) | `minecraft` | Minecraft |

## Fonts

| Font | Cask | Description |
|------|------|-------------|
| JetBrains Mono NF | `font-jetbrains-mono-nerd-font` | Nerd Font build of JetBrains Mono |
| Maple Mono NF | `font-maple-mono-nf` | Coding font with Nerd Font icons |
| Meslo LG Nerd Font | `font-meslo-lg-nerd-font` | Patched Meslo for Powerline and icon support |
| Monaspace NF | `font-monaspace-nf` | GitHub's Monaspace family with Nerd Font icons (used by Ghostty and Wezterm) |

## Mac App Store

| App | Ref | Description |
|-----|-----|-------------|
| Davinci Resolve | `mas "Davinci Resolve", id: 571213070` | Video editor; `mas` itself is a tracked brew formula |

## Homebrew formulae in this module

`borders` (focus rings for AeroSpace), `kanata` (key remapper), and `mas`. Everything else
lives in the other modules — see [utilities.md](utilities.md).
