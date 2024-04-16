local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- config.window_background_opacity = 0.5
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font_with_fallback({
  {
    family = 'Cascadia Code PL',
    harfbuzz_features = { 'calt', 'ss01', 'ss02' }
  },
  'Symbols Nerd Font',
  'Noto Color Emoji',
})
config.font_size = 14
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local new_window_from_cwd = function(_, pane)
  local prefix = 'file://archlinux'
  local dir = pane:get_current_working_dir()
  if string.find(dir, prefix) then
    dir = string.sub(dir, string.len(prefix) + 1)
  end
  wezterm.mux.spawn_window({ cwd = dir })
end

config.keys = {
  {
    mods = 'CTRL',
    key = 'Enter',
    action = wezterm.action_callback(new_window_from_cwd),
  },
  {
    mods = 'CTRL',
    key = 'Backspace',
    action = wezterm.action.SendKey({
      mods = 'CTRL',
      key = 'w'
    })
  },
  {
    mods = 'CTRL',
    key = 'w',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
