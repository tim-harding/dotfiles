local augroup = vim.api.nvim_create_augroup('Commands', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
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

vim.api.nvim_create_user_command('GoFast', function()
  vim.treesitter.stop()
  vim.cmd.syntax(false)
  vim.cmd('IBLDisable')
  vim.opt.cursorline = false
  vim.opt.wrap = false
end, {})

local buf_to_close = -1

vim.api.nvim_create_autocmd('BufLeave', {
  group = augroup,
  pattern = '*',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    buf_to_close = -1
    if vim.api.nvim_buf_get_name(buf) == '' and vim.api.nvim_buf_line_count(buf) < 2 then
      buf_to_close = buf
    end
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup,
  pattern = '*',
  callback = function()
    if buf_to_close > 0 and vim.api.nvim_buf_is_valid(buf_to_close) then
      vim.api.nvim_buf_delete(buf_to_close, {})
    end
  end
})

vim.api.nvim_create_autocmd('FocusGained', {
  group = augroup,
  pattern = '*',
  callback = function()
    pcall(vim.cmd.checktime)
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.cmd.startinsert()
  end
})

vim.api.nvim_create_autocmd('TermClose', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {})
  end
})
