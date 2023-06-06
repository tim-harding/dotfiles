return {
  'mfussenegger/nvim-dap',
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
