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

config.color_scheme = 'Solarized Osaka Dark'
config.font = wezterm.font 'Maple Mono NF'

config.quit_when_all_windows_are_closed = false
config.enable_scroll_bar = true
config.window_close_confirmation = 'NeverPrompt'

-- Finally, return the configuration to wezterm:
return config