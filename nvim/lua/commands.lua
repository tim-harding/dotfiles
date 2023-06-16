vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command('SetIndent', function(opts)
  local n = tonumber(opts.args)
  vim.bo.shiftwidth = n
  vim.bo.tabstop = n
  vim.bo.softtabstop = n
  vim.bo.expandtab = true
end, { nargs = 1 })
