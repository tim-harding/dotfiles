return {
  'SmiteshP/nvim-navbuddy',
  config = function()
    local navbuddy = require('nvim-navbuddy')
    local actions = require('nvim-navbuddy.actions')
    navbuddy.setup({
      mappings = {
        ['<up>'] = actions.previous_sibling(),
        ['<down>'] = actions.next_sibling(),
        ['<left>'] = actions.parent(),
        ['<right>'] = actions.children(),
        ['_'] = actions.root(),
      }
    })
  end,
  dependencies = {
    {
      'SmiteshP/nvim-navic',
      opts = {
        highlight = true,
      },
    },
    'MunifTanjim/nui.nvim',
  },
}
