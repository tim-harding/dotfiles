local wezterm = require('wezterm')
local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font_with_fallback({
    'Cascadia Code',
    'Symbols Nerd Font',
})
config.font_size = 13
config.enable_tab_bar = false
config.window_padding = {
    left = 3,
    right = 3,
    top = 0,
    bottom = 0,
}
return config
