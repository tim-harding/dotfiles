local anvimator = require 'anvimator'
local neophyte = require 'neophyte'

local function hide_statusline()
  vim.o.laststatus = 0
  vim.o.statusline = "%{repeat('-', winwidth('.'))}"
  vim.cmd.highlight {
    bang = true,
    args = { 'link', 'StatusLine', 'Normal' },
  }
  vim.cmd.highlight {
    bang = true,
    args = { 'link', 'StatusLineNC', 'Normal' },
  }
end

local function main()
  hide_statusline()
  vim.cmd.terminal()
  vim.cmd('!mkdir video-lab-1')
  neophyte.start_render('./')
  anvimator.input('iHello, world. It is I.<esc><left><left>iarst<esc>')
end

return function()
  anvimator.execute_async(main)
end
