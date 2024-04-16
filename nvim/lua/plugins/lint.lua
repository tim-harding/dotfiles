return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'staticcheck' },
    }

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('lint', {}),
      pattern = '*',
      callback = lint.try_lint,
    })
  end
}