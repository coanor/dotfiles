-- See https://wezfurlong.org/wezterm/config/files.html
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme    =
'zenburned'
-- 'Batman'
-- 'AdventureTime'
-- '3024 Night'
-- 'Maia (Gogh)'

config.enable_tab_bar = true

config.font = wezterm.font(
	'JetBrains Mono',
	-- 'Fira Code',
	{ weight='Bold', italic=false}
)

config.font_size=11.0

-- and finally, return the configuration to wezterm
return config
