return {
  'stevearc/oil.nvim',
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['<leader>f'] = 'actions.close',
    }
  },
  keys = {
    { '<leader>f', function() require('oil').open() end, desc = 'File browser' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
