return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'setnfuplgmbjcvkriwyxaoqz',
    search = {
      multi_window = false,
    },
    jump = {
      autojump = true,
    },
    modes = {
      char = {
        highlight = {
          backdrop = false,
        },
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
    },
  },
}
