local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts = vim.tbl_extend('keep', opts, {
    silent = true,
    remap = false,
    desc = desc,
  })
  vim.keymap.set(mode, keys, func, opts)
end

-- TODO: Does this need to be created per-client like the formatting one?
local highlight_augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })

M.on_attach = function(client, bufnr)
  local map = function(m, keys, func, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, keys, func, opts)
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = highlight_augroup,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorHoldI' }, {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = highlight_augroup,
    })
  end

  map('n', '<leader>r', vim.lsp.buf.rename, 'rename')
  map('n', 'gh', vim.lsp.buf.hover, 'hover')
  map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')
  map({ 'n', 'x' }, '<leader><leader>', vim.lsp.buf.code_action, 'code action')
  map('n', 'k', vim.diagnostic.goto_next, 'next diagnostic')
  map('n', 'K', vim.diagnostic.goto_prev, 'previous diagnostic')
end

M.is_quickfix_open = function()
  local is_quickfix_open = false
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      is_quickfix_open = true
    end
  end
  return is_quickfix_open
end

return M
