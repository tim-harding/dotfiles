return {
  'jose-elias-alvarez/null-ls.nvim',
  lazy = false,
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.ocamlformat,
        -- null_ls.builtins.formatting.stylish_haskell,
        null_ls.builtins.formatting.fourmolu,
      }
    })
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
}
