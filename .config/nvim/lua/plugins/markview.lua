return {
  "nvim-tree/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter",
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,
    opts = {
      callbacks = {
        injections = {
          languages = {
            markdown = {
              --- This disables other
              --- injected queries!
              overwrite = true,
              query = [[
                    (section
                        (atx_headng) @injections.mkv.fold
                        (#set! @fold))
                ]]
            }
          }
        },
        on_enable = function()
          vim.opt_local.foldmethod = "expr";
          vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()";
        end
      }
    }
  }
}
