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

    local map = require('shared').map
    map('n', '<Leader>nn', '<Cmd>Neorg workspace notes<Cr>', 'Neorg notes')

    vim.api.nvim_create_autocmd('Filetype', {
      group = vim.api.nvim_create_augroup('neorg', {}),
      pattern = 'norg',
      callback = function()
        -- Available bindings:
        -- https://github.com/nvim-neorg/neorg/wiki/Default-Keybinds
        map('n', '<Leader>nn', '<Plug>(neorg.dirman.new-note)', 'New note', { buffer = true })
      end,
    })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end
}
