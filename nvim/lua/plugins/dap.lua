return {
  'mfussenegger/nvim-dap',

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,

  keys = {
    { '<F5>',      function() require('dap').continue() end },
    { '<F1>',      function() require('dap').terminate() end },
    { '<F10>',     function() require('dap').step_over() end },
    { '<F11>',     function() require('dap').step_into() end },
    { '<F12>',     function() require('dap').step_out() end },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'toggle breakpoint' },
    { '<F9>',      function() require('dapui').toggle() end },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'breakpoint condition'
    },
  },

  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      opts = {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
        layouts = {
          {
            elements = {
              {
                id = 'stacks',
                size = 0.33
              },
              {
                id = 'scopes',
                size = 0.67
              },
            },
            position = 'top',
            size = 15,
          },
          {
            elements = {
              {
                id = 'console',
                size = 1
              }
            },
            position = 'bottom',
            size = 4,
          },
          {
            elements = {
              {
                id = 'breakpoints',
                size = 0.5
              },
              {
                id = 'watches',
                size = 0.5
              }
            },
            position = 'left',
            size = 1,
          },
        },
      },
    },

    {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
        automatic_setup = true,
        handlers = {},
      }
    },
  }
}
