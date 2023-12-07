return {
  'smjonas/inc-rename.nvim',
  enabled = false,
  opts = {},
  keys = {
    {
      '<leader>r',
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true
    }
  }
}
