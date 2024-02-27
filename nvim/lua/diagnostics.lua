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

vim.keymap.set('n', '<leader>t', toggle_diagnostics, { desc = 'Open workspace diagnostics' })

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
