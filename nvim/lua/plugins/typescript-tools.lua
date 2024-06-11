local on_attach = require('shared').on_attach

return {
  'pmizio/typescript-tools.nvim',
  enabled = false,
  ft = {
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
  },
  opts = {
    on_attach = on_attach,
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig'
  },
}
