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
  }
}

return config
