# Keyboard and Windows

## Layout: Gallium

The keyboard uses the [Gallium layout](https://github.com/galliumkb/gallium) — an alternative
layout optimized for comfort and reduced finger travel compared to QWERTY.

## Kanata

[Kanata](https://github.com/jtroo/kanata) is a cross-platform software keyboard remapper
that applies the Gallium layout. It is a tracked brew formula.

### Config location

The config is `~/config/Gallium.cfg`, tracked at `source/config/Gallium.cfg`. It defines
the Gallium key mappings and layers.

### LaunchDaemon (macOS)

Kanata runs as a user LaunchDaemon. The plist is tracked as a haven template at
`source/config/LaunchDaemons/com.example.kanata.plist.tmpl`, deployed to
`~/config/LaunchDaemons/`, and installed at
`/Library/LaunchDaemons/com.example.kanata.plist`.

It is a template because the binary path is resolved at apply time: `data.kanata_path` from
`haven data` if set, otherwise `/opt/homebrew/bin/kanata` on macOS and `kanata` elsewhere.

To restart Kanata after config changes:

```sh
sudo launchctl kickstart -k system/com.example.kanata
```

`KeepAlive` is set, so the daemon comes back on its own; `RunAtLoad` starts it at boot.

### Karabiner

`org.custom.karabiner.plist` is tracked alongside the Kanata plist, and Karabiner Elements
is a tracked cask. It handles the remaps that need to happen below the OS input layer;
Kanata handles the layout itself.

## Window management: AeroSpace

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is a tiling window manager,
configured in `~/.config/aerospace/aerospace.toml`:

- i3-style workspace model with five persistent workspaces
- Keys `h`/`a`/`o`/`e` move focus left/down/up/right (Gallium home row)
- `on-focused-monitor-changed` recenters the mouse on the focused monitor
- `exec-on-workspace-change` calls `set_wp_for_workspace.fish` to switch the desktop
  wallpaper per workspace

`felixkratz/formulae/borders` draws the focus ring. AeroSpace starts it with
`active_color=0xffffffff inactive_color=0x00000000 width=7.0 hidpi=on`, so the focused
window gets a white border and unfocused windows get nothing.

## Helix keybindings

The Helix config (`~/.config/helix/config.toml`) adjusts keybindings for the Gallium layout
and uses Helix's built-in `ayu_dark` theme. Helix is **not currently installed**; the config
is tracked for whenever it is.

## Hardware

[Keymapp](https://www.zsa.io/keymapp/) configures ZSA keyboards (Moonlander, Voyager) via
QMK firmware. [Karabiner Elements](https://karabiner-elements.pqrs.org/) handles lower-level
remapping.
