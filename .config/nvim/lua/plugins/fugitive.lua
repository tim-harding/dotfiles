return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  config = function()
    local map = require('shared').map

    local function commit()
      vim.cmd('Git commit')
    end

    local function amend()
      vim.cmd('Git commit --amend --no-edit')
    end

    local function push()
      vim.cmd('Git push')
    end

    map('n', '<leader>gc', commit, 'commit')
    map('n', '<leader>gP', push, 'push')
    map('n', '<leader>ga', amend, 'amend')
  end
}
