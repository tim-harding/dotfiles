local map = require('shared').map

return {
  'folke/trouble.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local trouble = require('trouble')
    trouble.setup({
      height = 3,
    })

    map('n', '<leader>t', ':TroubleToggle<cr>', 'toggle trouble')
    map('n', ']t', function()
      trouble.next({
        skip_groups = true,
        jump = true
      })
    end, 'trouble diagnostic')
    map('n', '[t', function()
      trouble.previous({
        skip_groups = true,
        jump = true
      })
    end, 'trouble diagnostic')
  end,
}
