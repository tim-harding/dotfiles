local map = require('shared').map

return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  config = function()
    map('n', 'hc', ':Git commit --quiet<cr>', 'commit')
    map('n', 'hP', ':Git push<cr>', 'push')
    map('n', 'ha', ':Git commit --amend --no-edit<cr>', 'amend')
  end
}
