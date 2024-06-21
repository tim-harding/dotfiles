return {
  'nvim-pack/nvim-spectre',
  opts = {
    open_cmd = 'new',
  },
  cmd = 'Spectre',
  keys = {
    {
      '<leader>S',
      function()
        require('spectre').toggle()
      end,
      desc = 'toggle spectre',
    }
  }
}
