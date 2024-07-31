local wezterm = require('wezterm')
local config = wezterm.config_builder()

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
-- config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local function cwd(pane)
  local prefix = 'file://archlinux'
  local dir = pane:get_current_working_dir()
  if string.find(dir, prefix) then
    dir = string.sub(dir, string.len(prefix) + 1)
  end
  return dir
end

local function new_window_from_cwd(_, pane)
  wezterm.log_info('Spawning window')
  wezterm.mux.spawn_window({ cwd = cwd(pane) })
end

local function new_tab(win, pane)
  wezterm.log_info('Spawning tab')
  win:spawn_tab { cwd = pane:get_current_working_directory() }
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
  {
    mods = 'CTRL',
    key = 'i',
    action = wezterm.action_callback(function() wezterm.log_info('hi') end),
  },
}

return config
