return {
  'nvim-tree/nvim-web-devicons',
  {
    'stevearc/oil.nvim',
    lazy = false,
    config = function()
      local oil = require 'oil'
      oil.setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        lsp_file_methods = {
          autosave_changes = true,
        },
        keymaps = {
          ['<leader>f'] = 'actions.close',
          ["-"] = false,
          ["<tab>"] = 'actions.parent',
        }
      }
      vim.keymap.set('n', '<leader>f', function() require('oil').open() end, {})
    end,
  }
}
