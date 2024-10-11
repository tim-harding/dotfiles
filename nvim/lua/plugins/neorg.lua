-- MacOS note:
-- The treesitter plugin did not compile without this
-- set --export CC=gcc-14
return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  config = function()
    local neorg = require 'neorg'
    neorg.setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end
}
