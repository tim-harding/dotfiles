-- vim.api.nvim_create_autocmd('FileType', {
--   group = vim.api.nvim_create_augroup('SetIndent', { clear = true }),
--   pattern = '*',
--   callback = function()
--     local ft = vim.bo.filetype
--     local spaces = 4
--     if ft == 'html' or
--         ft == 'javascript' or
--         ft == 'jsx' or
--         ft == 'typescript' or
--         ft == 'tsx' or
--         ft == 'css' or
--         ft == 'scss'
--     then
--       spaces = 2
--     end
--     vim.opt_local.tabstop = spaces
--     vim.opt_local.softtabstop = spaces
--     vim.opt_local.shiftwidth = spaces
--     vim.opt.expandtab = true
--   end
-- })
--
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})
