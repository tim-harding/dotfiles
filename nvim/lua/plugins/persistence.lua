return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    {
      '<leader>o',
      function() require('persistence').load() end,
      desc = 'Reopen session'
    },
  }
}
