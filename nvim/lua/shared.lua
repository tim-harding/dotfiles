local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts = vim.tbl_extend("keep", opts, {
    silent = true,
    remap = false,
    desc = desc,
  })
  vim.keymap.set(mode, keys, func, opts)
end

M.on_attach = function(client, bufnr)
  local map = function(m, keys, func, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, keys, func, opts)
  end

  map('n', '<leader>r', vim.lsp.buf.rename, 'rename')
  map('n', 'gh', vim.lsp.buf.hover, 'hover')
  map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')
  map('n', '<leader><leader>', vim.lsp.buf.code_action, 'code action')
  map('x', '<leader><leader>', function() vim.lsp.buf.range_code_action() end, 'code action')
  map('n', 'k', vim.diagnostic.goto_next, 'next diagnostic')
  map('n', 'K', vim.diagnostic.goto_prev, 'previous diagnostic')
end

return M
