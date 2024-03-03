return {
  'chrisgrieser/nvim-spider',
  keys = {
    {
      '<m-w>',
      function()
        require('spider').motion('w')
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      '<m-e>',
      function()
        require('spider').motion('e')
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      '<m-b>',
      function()
        require('spider').motion('b')
      end,
      mode = { 'n', 'o', 'x' },
    },
  },
}
