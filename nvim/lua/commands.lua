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

local buf_to_close = -1

vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  group = vim.api.nvim_create_augroup('MarkForClose', { clear = true }),
  pattern = { '*' },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    buf_to_close = -1
    if vim.api.nvim_buf_get_name(buf) == '' and vim.api.nvim_buf_line_count(buf) < 2 then
      buf_to_close = buf
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('CloseMarked', { clear = true }),
  pattern = { '*' },
  callback = function()
    if buf_to_close > 0 then
      pcall(vim.api.nvim_buf_delete, buf_to_close, { unload = true })
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('SetWgpu', { clear = true }),
  pattern = { '*.wgsl' },
  callback = function()
    vim.opt_local.filetype = 'wgsl'
  end
})

vim.api.nvim_create_autocmd('FocusGained', {
  group = vim.api.nvim_create_augroup('ReloadChangedFile', { clear = true }),
  pattern = '*',
  callback = function()
    pcall(vim.cmd.checktime)
  end
})
