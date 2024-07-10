local on_attach = require('shared').on_attach

return {
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  {
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
  }
}
