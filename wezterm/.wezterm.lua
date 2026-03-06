-- See https://wezfurlong.org/wezterm/config/files.html
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme =
-- 'zenburned'
-- 'Batman'
-- 'AdventureTime'
-- '3024 Night'
-- 'Maia (Gogh)'
-- 'Bamboo'
-- 'Bamboo Multiplex'
'Bamboo Blueberry'

config.enable_tab_bar = true

config.font = wezterm.font(
	'JetBrains Mono',
	--'Fira Code',
	{ weight='Bold', italic=false}
)

config.window_frame = {
        -- 设置Tab栏的字体家族
        font = wezterm.font('JetBrains Mono'),
        -- 设置Tab栏的字体大小
        font_size = 8.0,

        -- 其他可选的美化设置（非必须）
        -- active_titlebar_bg = '#333333',
        -- inactive_titlebar_bg = '#222222',
    }

config.font_size=8.0

-- and finally, return the configuration to wezterm
return config
