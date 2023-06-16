return {
  'stevearc/oil.nvim',
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      -- ['<leader>f'] = 'actions.parent',
      ['<leader>f'] = 'actions.close',
    }
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
