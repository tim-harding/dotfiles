local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end

M.on_attach = function(_, bufnr)
  local map = function(m, keys, func, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, keys, func, opts)
  end

  map('n', 'K', vim.lsp.buf.hover, 'hover')
  map('n', 'gd', vim.lsp.buf.definition, 'definition')
  map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
  map('n', 'gi', vim.lsp.buf.implementation, 'implementation')
  map('n', 'gt', vim.lsp.buf.type_definition, 'type definition')
  map('n', 'gr', vim.lsp.buf.references, 'references')
  map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')

  map('n', 'la', vim.lsp.buf.code_action, 'code action')
  map('x', 'la', function() vim.lsp.buf.range_code_action() end, 'code action')
  map('n', 'lc', vim.lsp.buf.rename, 'change name')
  map('n', 'ld', vim.diagnostic.open_float, 'diagnostic float')
  map('n', '[d', vim.diagnostic.goto_prev, 'previous diagnostic]')
  map('n', ']d', vim.diagnostic.goto_next, 'next diagnostic')
end

return M
