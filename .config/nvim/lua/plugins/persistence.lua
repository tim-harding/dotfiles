return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    need = 0,
    pre_save = function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
    end,
  },
}
