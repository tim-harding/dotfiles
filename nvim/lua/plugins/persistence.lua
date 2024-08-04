return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    options = { 'globals' },
    pre_save = function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
    end,
  },
}
