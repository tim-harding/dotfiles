return {
  'stevearc/oil.nvim',
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['<leader>f'] = 'actions.parent',
    }
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
