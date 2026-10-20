-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 156
config.initial_rows = 40

-- or, changing the font size and color scheme.
config.font_size = 15

--config.color_scheme = 'Solarized Osaka Dark'

-- Ayu Dark, defined locally so no plugin is fetched at startup. These are the canonical
-- ayu-colors ANSI values; the fish theme and the starship palette express the same palette
-- in their own vocabularies and are not derived from this table.
config.colors = {
  foreground = '#BFBDB6',
  background = '#0B0E14',
  cursor_bg = '#E6B450',
  cursor_border = '#E6B450',
  cursor_fg = '#0B0E14',
  selection_bg = '#409FFF',
  selection_fg = '#0B0E14',
  scrollbar_thumb = '#2D3640',
  split = '#1C1F26',
  visual_bell = '#F07178',
  ansi = {
    '#01060E', -- black
    '#EA6C73', -- red
    '#91B362', -- green
    '#F9AF4F', -- yellow
    '#53BDFA', -- blue
    '#FAE994', -- magenta
    '#90E1C6', -- cyan
    '#C7C7C7', -- white
  },
  brights = {
    '#686868', -- bright black
    '#F07178', -- bright red
    '#C2D94C', -- bright green
    '#FFB454', -- bright yellow
    '#59C2FF', -- bright blue
    '#FFEE99', -- bright magenta
    '#95E6CB', -- bright cyan
    '#FFFFFF', -- bright white
  },
}

--config.font = wezterm.font 'Maple Mono NF'
config.font = wezterm.font 'Monaspace Neon NF Light'

config.quit_when_all_windows_are_closed = false
config.enable_scroll_bar = true
config.window_close_confirmation = 'NeverPrompt'
--config.quick_select_remove_styling = true

config.keys = {
   {
      key = 'LeftArrow',
      mods = 'CMD',
      action = wezterm.action { SendString = "\x1bOH" },
   },
   {
      key = 'RightArrow',
      mods = 'CMD',
      action = wezterm.action { SendString = "\x1bOF" },
   },
}

-- Finally, return the configuration to wezterm:
return config
