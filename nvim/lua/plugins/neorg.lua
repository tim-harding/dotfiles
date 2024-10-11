-- MacOS note:
-- The treesitter plugin did not compile without this
-- set --export CC=gcc-14 && nvim -c "TSInstallSync norg"
return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  config = function()
    local neorg = require 'neorg'
    neorg.setup {
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        -- Future option: LaTeX rendering with ghostty
        -- https://github.com/nvim-neorg/neorg/wiki/Cookbook#latex-rendering
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end
}
