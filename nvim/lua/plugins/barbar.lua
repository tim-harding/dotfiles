return {
  'romgrk/barbar.nvim',
  event = 'VeryLazy',

  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  init = function()
    vim.g.barbar_auto_setup = false
  end,

  config = function()
    local barbar = require('barbar')
    local bbye = require('barbar.bbye')
    local api = require('barbar.api')

    barbar.setup({
      auto_hide = true,
      animation = false,
      focus_on_close = 'right',
      insert_at_end = true,
      clickable = false, -- Weird behavior when tested
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

    vim.keymap.set('n', '<c-c>', function()
      bbye.bdelete(false)
    end)
    vim.keymap.set('n', '<s-left>', function()
      api.goto_buffer_relative(-1)
    end)
    vim.keymap.set('n', '<s-right>', function()
      api.goto_buffer_relative(1)
    end)
    vim.keymap.set('n', '<s-up>', function()
      api.move_current_buffer(-1)
    end)
    vim.keymap.set('n', '<s-down>', function()
      api.move_current_buffer(1)
    end)
    vim.keymap.set('n', '<leader>c', function()
      api.close_all_but_current_or_pinned()
    end)
    vim.keymap.set('n', '<c-p>', function()
      api.toggle_pin()
    end)
  end
}
