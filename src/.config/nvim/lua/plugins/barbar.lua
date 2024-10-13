return {
  'lewis6991/gitsigns.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',

    init = function()
      vim.g.barbar_auto_setup = false
    end,

    config = function()
      local barbar = require('barbar')
      local bbye = require('barbar.bbye')
      local api = require('barbar.api')
      local map = require('shared').map

      barbar.setup({
        auto_hide = true,
        animation = false,
        focus_on_close = 'right',
        insert_at_end = true,
        clickable = true,
        exclude_ft = { 'qf' },
        icons = {
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = false },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = false },
          },
          gitsigns = {
            added = { enabled = false },
            changed = { enabled = false },
            deleted = { enabled = false },
          },
          filetype = {
            enabled = false,
          },
          pinned = {
            button = '',
            filename = true,
          },
        }
      })

      map('n', '<c-c>', function() bbye.bdelete(false) end)
      map('n', '<c-h>', function() api.goto_buffer_relative(-1) end)
      map('n', '<c-l>', function() api.goto_buffer_relative(1) end)
      map('n', '<c-j>', function() api.move_current_buffer(-1) end)
      map('n', '<c-k>', function() api.move_current_buffer(1) end)
      map('n', '<s-left>', function() api.goto_buffer_relative(-1) end)
      map('n', '<s-right>', function() api.goto_buffer_relative(1) end)
      map('n', '<s-up>', function() api.move_current_buffer(-1) end)
      map('n', '<s-down>', function() api.move_current_buffer(1) end)
      map('n', '<leader>c', api.close_all_but_current_or_pinned, 'close all')
      map('n', '<c-p>', api.toggle_pin)
    end
  }
}
