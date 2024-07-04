return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'staticcheck' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
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
