return {
  'nvim-pack/nvim-spectre',
  opts = {
    open_cmd = 'new',
  },
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
