local shared = require 'shared'

local dir = nil
local local_path = vim.env.HOME .. '/Documents/personal/23/07/neophyte'
if shared.path_exists(local_path) then
  dir = local_path
end

return {
  'tim-harding/neophyte',
  dir = dir,
  priority = 2000,
  lazy = false,
  init = function()
    if vim.g.shadowvim then
      return
    end

    local scroll_speed = 2
    if shared.is_darwin() then
      scroll_speed = 1
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

    if shared.is_darwin() then
      vim.keymap.set('n', '<DC-f>', function()
        neophyte.set_fullscreen(not neophyte.get_fullscreen())
      end)
    end
  end,
}
