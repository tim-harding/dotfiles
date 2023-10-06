return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'SETNRIGMFUPLWYCDHXAOQ',
    modes = {
      char = {
        enabled = false,
      }
    }
  },
  keys = {
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function() require('flash').treesitter() end,
      desc = 'Flash Treesitter',
    }
  }
}
