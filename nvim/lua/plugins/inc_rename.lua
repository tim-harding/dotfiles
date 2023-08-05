return {
  'smjonas/inc-rename.nvim',
  opts = {
    input_buffer_type = 'dressing',
  },
  keys = {
    {
      '<leader>r',
      function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
      expr = true,
      desc = 'rename',
    }
  }
}
