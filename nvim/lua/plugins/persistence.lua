return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      '<leader>o',
      function() require('persistence').load() end,
      'n',
      { desc = 'load persitence' },
    },
  },
  opts = {
    options = {
      -- "buffers",
      "curdir",
      "tabpages",
      "winsize",
    },
  },
}
