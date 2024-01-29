local elements = { 'scopes', 'Stacks', 'watches', 'breakpoints', 'repl', 'console' }
local layout_keys = {}
for i, element in ipairs(elements) do
  table.insert(layout_keys, {
    string.format('<leader>d%s', string.sub(element, 0, 1)),
    function()
      require('dapui').open({ layout = i })
    end,
    desc = string.format('%s DAP window', element),
  })
end

return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap' },

  keys = {
    {
      '<leader>df',
      function()
        require('dapui').float_element()
      end,
      desc = 'float DAP window',
    },

    unpack(layout_keys)
  },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local widgets = require('dap.ui.widgets')
    local map = require('shared').map

    local layouts = {}
    for _, element in ipairs(elements) do
      table.insert(layouts, {
        position = 'bottom',
        size = 12,
        elements = { element }
      })
    end

    dapui.setup({ layouts = layouts })

    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close
    dap.listeners.after.event_initialized.me = function()
      map('n', 'gH', widgets.hover, 'DAP hover')
    end
    dap.listeners.after.event_terminated.me = function()
      map('n', 'gH', '<nop>')
    end
  end,
}
