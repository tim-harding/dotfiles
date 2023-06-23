return {
  'bennypowers/splitjoin.nvim',
  keys = {
    { '<leader>J', function() require('splitjoin').join() end,  desc = 'join' },
    { '<leader>j', function() require('splitjoin').split() end, desc = 'split' },
  },
}
