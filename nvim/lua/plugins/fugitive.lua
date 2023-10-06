local map = require('shared').map

return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  config = function()
    map('n', '<leader>gc', ':Git commit --quiet<cr>', 'commit')
    map('n', '<leader>gP', ':Git push<cr>', 'push')
    map('n', '<leader>ga', ':Git commit --amend --no-edit<cr>', 'amend')
  end
}
