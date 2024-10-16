vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  severity_sort = true,
})

local function show_diagnostics()
  vim.diagnostic.setqflist({
    open = false,
    severity = { min = vim.diagnostic.severity.WARN, },
    severity_sort = true,
  })
end

local are_diagnostics_open = false

local function toggle_diagnostics()
  are_diagnostics_open = not are_diagnostics_open
  if are_diagnostics_open then
    vim.cmd.copen()
    show_diagnostics()
  else
    vim.cmd.cclose()
  end
end

local function is_quickfix_open()
  local is_open = false
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      is_open = true
    end
  end
  return is_open
end

local function toggle_quickfix()
  if is_quickfix_open() then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

local default_handler = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {}
)

local function on_publish_diagnostics(err, method, result, client_id, bufnr, config)
  default_handler(err, method, result, client_id, bufnr, config)
  if are_diagnostics_open then
    show_diagnostics()
  end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = on_publish_diagnostics

local map = require('shared').map
map('n', '<leader>d', toggle_diagnostics, 'open workspace diagnostics')
map('n', '<leader>q', toggle_quickfix, 'toggle quickfix list')
map('n', ']q', ':cnext', 'next quickfix list item')
map('n', '[q', ':cprev', 'prev quickfix list item')
