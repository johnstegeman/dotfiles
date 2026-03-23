# Keyboard

## Layout: Gallium

The keyboard uses the [Gallium layout](https://github.com/galliumkb/gallium) — an alternative layout optimized for comfort and reduced finger travel compared to QWERTY.

## Kanata

[Kanata](https://github.com/jtroo/kanata) is a cross-platform software keyboard remapper that applies the Gallium layout. On macOS it runs as a LaunchDaemon, managed by a chezmoi template that resolves the correct binary path.

### LaunchDaemon (macOS)

The plist is stored in `config/LaunchDaemons/` as a chezmoi template (`com.example.kanata.plist.tmpl`). It is applied to `~/Library/LaunchAgents/` and automatically starts Kanata at login.

To restart Kanata after config changes:

```sh
launchctl unload ~/Library/LaunchAgents/com.example.kanata.plist
launchctl load ~/Library/LaunchAgents/com.example.kanata.plist
```

### Config location

The Kanata config is at `~/.config/kanata/`. It defines the Gallium key mappings and any layers/macros.

## Helix keybindings

Helix keybindings are adjusted for the Gallium layout. The Helix config is at `~/.config/helix/config.toml`.

## Hardware

[Keymapp](https://www.zsa.io/keymapp/) is installed for configuring ZSA keyboards (Moonlander, Voyager, etc.) via QMK firmware. [Karabiner Elements](https://karabiner-elements.pqrs.org/) is also available for lower-level key remapping.
