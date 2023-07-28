return {
  'Wansmer/treesj',
  keys = {
    {
      '<space>,',
      function() require('treesj').toggle() end,
      desc = 'Split toggle',
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 8192,
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
