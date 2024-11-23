return {
  'nvim-neotest/nvim-nio',
  'nvim-lua/plenary.nvim',
  'antoinemadec/FixCursorHold.nvim',
  "marilari88/neotest-vitest",

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
          require 'neotest-vitest'
        },
        log_level = vim.log.levels.INFO,
      }

      map('n', '<leader>tn', function() run.run { strategy = 'dap' } end, 'debug test')
      map('n', '<leader>tr', run.run, 'run test')
      map('n', '<leader>tf', function() run.run(vim.fn.expand('%')) end, 'test file')
      map('n', '<leader>tr', run.stop, 'stop test')
      map('n', '<leader>ta', run.attach, 'attach test')
    end,
  }
}
