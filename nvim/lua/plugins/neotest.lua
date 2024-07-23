return {
  'nvim-neotest/nvim-nio',
  'nvim-lua/plenary.nvim',
  'antoinemadec/FixCursorHold.nvim',

  'lawrence-laz/neotest-zig',
  -- 'mrcjkb/neotest-haskell',
  'nvim-neotest/neotest-python',
  'nvim-neotest/neotest-plenary',
  'nvim-neotest/neotest-go',
  'nvim-neotest/neotest-jest',
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    config = function()
      local neotest = require 'neotest'
      local shared = require 'shared'
      local run = require 'neotest.consumers.run'
      local map = shared.map

      neotest.setup {
        adapters = {
          require 'rustaceanvim.neotest',
          require 'neotest-zig',
          -- require 'neotest-haskell',
          require 'neotest-python',
          require 'neotest-plenary',
          require 'neotest-go',
          require 'neotest-jest',
        },
        log_level = vim.log.levels.INFO,
      }

      map('n', '<leader>nn', function() run.run { strategy = 'dap' } end, 'debug test')
      map('n', '<leader>nr', run.run, 'run test')
      map('n', '<leader>nf', function() run.run(vim.fn.expand('%')) end, 'test file')
      map('n', '<leader>nr', run.stop, 'stop test')
      map('n', '<leader>na', run.attach, 'attach test')
    end,
  }
}
