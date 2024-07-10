return {
  'mfussenegger/nvim-dap-python',
  event = 'VeryLazy',
  config = function()
    require('dap-python').setup('python3')
  end
}
