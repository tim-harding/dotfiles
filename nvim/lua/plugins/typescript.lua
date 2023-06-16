local on_attach = require('util').on_attach

return {
  'jose-elias-alvarez/typescript.nvim',
  opts = {
    server = {
      on_attach = on_attach,
    }
  },
}
