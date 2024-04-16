return {
  'mfussenegger/nvim-dap-python',
  event = 'VeryLazy',
  config = function()
    local dap_python = require('dap-python')
    dap_python.setup('/opt/homebrew/bin/python3')
  end
}
