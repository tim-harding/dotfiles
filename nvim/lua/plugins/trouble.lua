-- NOTE: Remember to delete stuff from Telescope after removing this

return {
  'folke/trouble.nvim',
  enabled = false,
  keys = {
    {
      '<leader>t',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>T',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>l',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>q',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[q',
      function() require('trouble').prev({ jump = true }) end,
      desc = 'Trouble previous',
    },
    {
      ']q',
      function() require('trouble').next({ jump = true }) end,
      desc = 'Trouble next',
    },
  },
  opts = {},
}
