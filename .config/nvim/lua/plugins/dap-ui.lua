return {
  'mfussenegger/nvim-dap',
  'nvim-neotest/nvim-nio',
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    enabled = false,

    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local map = require('shared').map

      local elements = { 'scopes', 'Stacks', 'watches', 'breakpoints', 'repl', 'console' }
      local layouts = {}
      for _, element in ipairs(elements) do
        table.insert(layouts, {
          position = 'bottom',
          size = 12,
          elements = { string.lower(element) }
        })
      end

      local function open()
        dapui.open({
          reset = true,
          layout = 1,
        })
      end

      dapui.setup({ layouts = layouts })
      dap.listeners.before.attach.dapui_config = open
      dap.listeners.before.launch.dapui_config = open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
      dap.listeners.after.event_initialized.me = function()
        map('n', 'gH', require('dap.ui.widgets').hover, 'DAP hover')
      end
      dap.listeners.after.event_terminated.me = function()
        map('n', 'gH', '<nop>')
      end

      map('n', '<leader>df', dapui.float_element, 'float DAP window')
      for i, element in ipairs(elements) do
        map(
          'n',
          string.format('<leader>d%s', string.sub(element, 0, 1)),
          function()
            require('dapui').open({ layout = i })
          end,
          string.format('%s DAP window', element)
        )
      end
    end,
  }
}
