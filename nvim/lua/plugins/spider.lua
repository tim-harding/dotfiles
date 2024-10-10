return {
  'chrisgrieser/nvim-spider',
  keys = {
    {
      '<a-w>',
      function()
        require('spider').motion('w')
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      '<a-e>',
      function()
        require('spider').motion('e')
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      '<a-b>',
      function()
        require('spider').motion('b')
      end,
      mode = { 'n', 'o', 'x' },
    },
  },
}
