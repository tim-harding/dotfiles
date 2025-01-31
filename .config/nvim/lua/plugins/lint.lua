return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'staticcheck' },
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescriptreact = { 'eslint' },
    }

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('lint', {}),
      pattern = '*',
      callback = function()
        lint.try_lint()
      end
    })
  end
}
