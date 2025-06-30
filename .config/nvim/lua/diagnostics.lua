vim.diagnostic.config({
  virtual_text = false,
  float = false,
  underline = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
})

local function goto(dir)
  vim.diagnostic.jump({
    count = dir,
    wrap = true,
    float = true,
  })
end

local function goto_next()
  goto(1)
end

local function goto_prev()
  goto(-1)
end

local map = require('shared').map
map('n', ']q', ':cnext', 'next quickfix list item')
map('n', '[q', ':cprev', 'prev quickfix list item')
map('n', '<m-cr>', vim.diagnostic.open_float, 'previous diagnostic')

map('n', '<cr>', goto_next, 'next diagnostic')
map('n', '<s-cr>', goto_prev, 'previous diagnostic')
