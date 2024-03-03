vim.g.mapleader = ' '
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.updatetime = 0
vim.opt.timeout = true
vim.opt.timeoutlen = 1200
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
vim.opt.expandtab = true
vim.opt.textwidth = 80
vim.opt.formatoptions = 'cqj' -- :h fo-table
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.opt.completeopt = 'menuone,noselect'
vim.opt.clipboard = 'unnamedplus'
vim.opt.inccommand = 'split'

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
