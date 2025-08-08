return {
  "ray-x/guihua.lua",
  "neovim/nvim-lspconfig",
  "nvim-treesitter/nvim-treesitter",
  {
    "ray-x/go.nvim",
    opts = {},
    config = function(lp, opts)
      local go = require 'go'
      go.setup(opts)
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()',
  }
}
