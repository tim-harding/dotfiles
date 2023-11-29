vim.g.mapleader = ' '
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true
vim.opt.scrolloff = 0
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.shortmess = 'aoOstTIFcC'
vim.opt.linebreak = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.hlsearch = false
vim.opt.sessionoptions:append('globals') -- For bufferline order persistence
-- vim.opt.guifont = "Cascadia Code PL:w10, Symbols Nerd Font, Noto Color Emoji"
-- vim.opt.textwidth = 80

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
    'Noto Color Emoji'
  },
  font_size = {
    kind = 'width',
    size = 10,
  },
  cursor_speed = 2,
  scroll_speed = 2,
  bg_override = {
    r = 48,
    g = 52,
    b = 70,
    a = 128,
  }
})

vim.keymap.set('n', '<c-+>', function()
  neophyte.set_font_width(neophyte.get_font_width() + 1)
end, { silent = true, remap = false })

vim.keymap.set('n', '<c-->', function()
  neophyte.set_font_width(neophyte.get_font_width() - 1)
end, { silent = true, remap = false })
