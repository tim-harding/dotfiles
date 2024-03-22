return {
  'xbase-lab/xbase',
  ft = { 'swift' },
  enabled = false,
  build = 'make install',
  requires = { 'neovim/nvim-lspconfig' },
  config = function()
    local xbase = require('xbase')
    local pickers = require('xbase.pickers.builtin')
    local logger = require('xbase.logger')

    xbase.setup({
      sourcekit = {},
      mappings = {
        enable = false,
      },
    })

    vim.keymap.set('n', '<leader>xl', function()
      logger.toggle(false, false)
    end, { desc = "Open logger" })

    vim.keymap.set('n', '<leader>xr', function()
      pickers.run({})
    end, { desc = "Run picker" })

    vim.keymap.set('n', '<leader>xb', function()
      pickers.build({})
    end, { desc = "Build picker" })

    vim.keymap.set('n', '<leader>xw', function()
      pickers.watch({})
    end, { desc = "Watch picker" })

    vim.keymap.set('n', '<leader>xa', function()
      pickers.actions({})
    end, { desc = "Action picker" })
  end
}
