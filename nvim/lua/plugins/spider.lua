return {
  'chrisgrieser/nvim-spider',
  enabled = false,
  keys = {
    {
      'w',
      function()
        require('spider').motion('w', { subwordMovement = false })
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      'e',
      function()
        require('spider').motion('e', { subwordMovement = false })
      end,
      mode = { 'n', 'o', 'x' },
    },

    {
      'b',
      function()
        require('spider').motion('b', { subwordMovement = false })
      end,
      mode = { 'n', 'o', 'x' },
    },

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
