return {
  'Wansmer/treesj',
  keys = {
    {
      '<space>j',
      function() require('treesj').toggle() end,
      desc = 'Split toggle',
    },
  },
  opts = {
    use_default_keymaps = false,
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
