vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.expandtab = true

vim.opt.timeout = true
vim.opt.updatetime = 0
vim.opt.timeoutlen = 1200

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.scrolloff = 0
vim.opt.textwidth = 80

vim.g.mapleader = vim.keycode '<Space>'
vim.g.maplocalleader = vim.keycode '<C-Space>'
vim.opt.mouse = 'a'
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.inccommand = 'split'
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- a: Abbreviations for commandline messages
-- o/O: File read overwrites previous messages
-- s: Don't show Search Hit Bottom messages
-- t/T: Truncate overly long messages
-- F: Don't show file info when editing a file
-- c/C: Don't show completion messages
vim.opt.shortmess = 'aoOstTIFcC'

-- :h fo-table
--
-- Doing this in an autocommand because something seems to be unsetting it
-- when I open files.
--
-- Interesting options: 'a' auto-reflows paragraphs in insert mode. Maybe
-- enable as a toggleable option.
--
-- q: Allow 'gq' formatting of comments
-- j: Remove a comment leader when joining lines
-- r: Insert comment leader on <cr> in insert mode
-- b/l: Avoids auto-wrapping long lines
vim.opt.formatoptions = 'qjrbl'

vim.fn.sign_define(
  "DiagnosticSignError",
  {
    text = " ",
    texthl = "DiagnosticSignError",
  }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  {
    text = " ",
    texthl = "DiagnosticSignWarn",
  }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  {
    text = " ",
    texthl = "DiagnosticSignInfo",
  }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  {
    text = "󰌵",
    texthl = "DiagnosticSignHint",
  }
)

vim.filetype.add {
  extension = {
    chpl = 'chapel',
    metal = 'cpp',
    wgsl = 'wgsl',
  }
}
