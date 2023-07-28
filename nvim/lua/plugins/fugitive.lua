local map = require('shared').map

return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  config = function()
    map('n', '<leader>hc', ':Git commit --quiet<cr>', 'commit')
    map('n', '<leader>hP', ':Git push<cr>', 'push')
    map('n', '<leader>ha', ':Git commit --amend --no-edit<cr>', 'amend')
  end
}
