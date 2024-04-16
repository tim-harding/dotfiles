local map = require('shared').map

vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  severity_sort = true,
})

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


map('n', '<cr>', vim.diagnostic.goto_next, 'next diagnostic')
map('n', '<s-cr>', vim.diagnostic.goto_prev, 'previous diagnostic')

vim.lsp.handlers['textDocument/publishDiagnostics'] = on_publish_diagnostics
