vim.loader.enable()
require('options')
require('lazy_setup')
require('commands')
require('keymap')
vim.cmd.colorscheme('catppuccin')

A = function()
    local n = require('neophyte')
    n.set_render_size(800, 600)
    n.set_font_width(14)
    n.set_cursor_speed(1)
    n.set_scroll_speed(0.25)
    vim.fn.chdir('/home/tim/.config/nvim')
end

P = function(v)
    print(vim.inspect(v))
    return v
end
