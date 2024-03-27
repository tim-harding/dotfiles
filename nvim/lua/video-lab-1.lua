local map = require 'shared'.map
local anvimator = require 'anvimator'

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
  anvimator.input('iHello, world. It is I.<esc><left><left>iarst<esc>')
  anvimator.input()
end

map({ 'n', 'x', 'i' }, '<f8>', anvimator.pause)
map({ 'n', 'x', 'i' }, '<f7>', anvimator.resume)

return function()
  anvimator.execute_async(main)
end
