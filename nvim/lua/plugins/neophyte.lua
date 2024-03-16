local scroll_speed = 2
local this_os = vim.loop.os_uname().sysname
if this_os:find('Darwin') then
  scroll_speed = 1
end

local spec = {
  lazy = false,
  priority = 2000,
  init = function()
    if vim.g.shadowvim then
      return
    end

    local neophyte = require('neophyte')
    neophyte.setup({
      fonts = {
        {
          name = 'Cascadia Code PL',
          features = {
            'calt', 'ss01', 'ss02',
          },
        },
        'Symbols Nerd Font',
        'Noto Color Emoji',
        'Noto Sans CJK JP',
      },
      font_size = {
        kind = 'width',
        size = 10,
      },
      cursor_speed = 2,
      scroll_speed = scroll_speed,
      bg_override = {
        r = 48,
        g = 52,
        b = 70,
        a = 128,
      }
    })

    vim.keymap.set('n', '<C-+>', function()
      neophyte.set_font_width(neophyte.get_font_width() + 1)
    end)
    vim.keymap.set('n', '<C-->', function()
      neophyte.set_font_width(neophyte.get_font_width() - 1)
    end)
  end,
}

local path_exists = function(path)
  local file = io.open(path, 'r')
  if file ~= nil then
    io.close(file)
    return true
  else
    return false
  end
end

local local_neophyte_path = vim.env.HOME .. '/Documents/personal/23/07/neophyte'

if path_exists(local_neophyte_path) then
  spec.dir = local_neophyte_path
else
  spec.url = 'https://github.com/tim-harding/neophyte'
end

return spec
