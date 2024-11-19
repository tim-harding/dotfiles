return {
  'nvim-tree/nvim-web-devicons',
  {
    'stevearc/oil.nvim',
    enabled = false,
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<leader>f'] = 'actions.close',
        ["-"] = false,
        ["<tab>"] = 'actions.parent',
      }
    },
    keys = {
      { '<leader>f', function() require('oil').open() end, desc = 'File browser' },
    },
  }
}
