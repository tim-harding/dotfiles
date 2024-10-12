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
        ["core.qol.toc"] = {
          config = {
            close_after_use = true,
          }
        },
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
        ["core.summary"] = {},
        -- Future option: LaTeX rendering with ghostty
        -- https://github.com/nvim-neorg/neorg/wiki/Cookbook#latex-rendering
      },
    }

    local map_shared = require('shared').map
    map_shared('n', '<Leader>nn', '<Cmd>Neorg workspace notes<Cr>', 'Neorg notes')

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('neorg', {}),
      pattern = 'norg',
      callback = function()
        -- Available bindings:
        -- https://github.com/nvim-neorg/neorg/wiki/Default-Keybinds
        local function map(keys, func, desc)
          map_shared('n', keys, func, desc, { buffer = true })
        end

        map('<Leader>nn', '<Plug>(neorg.dirman.new-note)', 'New note')
        map('<Leader>nr', '<Cmd>Neorg return<Cr>', 'Return')
        map('<Leader>nt', '<Cmd>Neorg toc<Cr>', 'Table of contents')
        map('<Cr>', '<Plug>(neorg.esupports.hop.hop-link)', 'Hop link')
        vim.keymap.set('i', '<S-Cr>', require('neorg.modules.core.itero.module').public.next_iteration_cr,
          { buffer = true })
      end,
    })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end
}
