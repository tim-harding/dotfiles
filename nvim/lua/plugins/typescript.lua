local on_attach = require('shared').on_attach

return {
  'jose-elias-alvarez/typescript.nvim',
  ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  opts = {
    server = {
      on_attach = on_attach,
    }
  },
}
