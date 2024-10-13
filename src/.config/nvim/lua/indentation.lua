vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('indentation', {}),
  pattern = {
    'css',
    'html',
    'javascript',
    'lua',
    'markdown',
    'typescript',
    'vue',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.opt.softtabstop = 2
  end
})
