return {
  'mfussenegger/nvim-dap',

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({
        layout = 0,
        reset = true,
      })
    end
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local sign = vim.fn.sign_define
    sign("DapBreakpoint", {
      text = "●",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })
    sign("DapBreakpointCondition", {
      text = "●",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    })
    sign("DapLogPoint", {
      text = "◆",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    })
  end,

  keys = {
    { '<F5>',  function() require('dap').continue() end },
    { '<F1>',  function() require('dap').terminate() end },
    { '<F10>', function() require('dap').step_over() end },
    { '<F11>', function() require('dap').step_into() end },
    { '<F12>', function() require('dap').step_out() end },
    { '<F9>',  function() require('dapui').toggle() end },
    {
      '<leader>b',
      function() require('dap').toggle_breakpoint() end,
      desc = 'toggle breakpoint'
    },
    {
      '<leader>dc',
      function() require('dap').clear_breakpoints() end,
      desc = 'clear breakpoints'
    },
    {
      '<leader>db',
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
        icons = {
          expanded = '▾',
          collapsed = '▸',
          current_frame = '*'
        },
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
            disconnect = '⏏'
          }
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 1 },
            },
            position = 'top',
            size = 20,
          },
          {
            elements = {
              { id = 'stacks',      size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'watches',     size = 0.25 },
              { id = 'console',     size = 0.25 },
            },
            position = 'bottom',
            size = 10,
          },
        }
      }
    }
  }
}
