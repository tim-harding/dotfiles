local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end

M.on_attach = function(client, bufnr)
  local map = function(m, keys, func, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, keys, func, opts)
  end

  -- Use Telescope for these?
  map('n', 'gr', vim.lsp.buf.references, 'references')
  map('n', 'gd', vim.lsp.buf.definition, 'definition')

  map('n', 'gh', vim.lsp.buf.hover, 'hover')
  map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
  map('n', 'gi', vim.lsp.buf.implementation, 'implementation')
  map('n', 'gt', vim.lsp.buf.type_definition, 'type definition')
  map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')

  map('n', '<leader><leader>', vim.lsp.buf.code_action, 'code action')
  map('x', '<leader><leader>', function() vim.lsp.buf.range_code_action() end, 'code action')
  map('n', '<leader>r', vim.lsp.buf.rename, 'change name')
  map('n', 'K', vim.diagnostic.open_float, 'diagnostic float')
  map('n', '[[', vim.diagnostic.goto_prev, 'previous diagnostic')
  map('n', ']]', vim.diagnostic.goto_next, 'next diagnostic')
end

return M
