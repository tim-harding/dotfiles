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

local function show_diagnostics()
  vim.diagnostic.setqflist({
    open = false,
    severity = { min = vim.diagnostic.severity.WARN, },
    severity_sort = true,
  })
end

local function is_quickfix_open()
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      return true
    end
  end
  return false
end

local function toggle_diagnostics()
  if is_quickfix_open() then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
    show_diagnostics()
  end
end

local function toggle_quickfix()
  if is_quickfix_open() then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

local function on_publish_diagnostics(err, result, context)
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, context)
  if is_quickfix_open() then
    show_diagnostics()
  end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = on_publish_diagnostics

local function goto(dir)
  vim.diagnostic.jump({
    count = dir, -- Doesn't seem to do anything?
    wrap = true,
    -- float = true, -- Errors at the moment
  })
end

local function goto_next()
  goto(1)
end

local function goto_prev()
  goto(-1)
end

local map = require('shared').map
map('n', '<leader>e', toggle_diagnostics, 'open workspace diagnostics')
map('n', '<leader>q', toggle_quickfix, 'toggle quickfix list')
map('n', ']q', ':cnext', 'next quickfix list item')
map('n', '[q', ':cprev', 'prev quickfix list item')
map('n', '<m-cr>', vim.diagnostic.open_float, 'previous diagnostic')

-- Until 11.0
if false then
  map('n', '<cr>', goto_next, 'next diagnostic')
  map('n', '<s-cr>', goto_prev, 'previous diagnostic')
else
  map('n', '<cr>', vim.diagnostic.goto_next, 'next diagnostic')
  map('n', '<s-cr>', vim.diagnostic.goto_prev, 'previous diagnostic')
end
