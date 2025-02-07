return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    -- Make sure barbar is already loaded
    'romgrk/barbar.nvim',
  },

  init = function()
    vim.opt.sessionoptions:append 'globals'
    vim.opt.sessionoptions:append 'options'
    vim.opt.sessionoptions:append 'localoptions'
  end,

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = {
      '~/',
      '~/Downloads',
      '/',
    },
    auto_restore = false,
    auto_restore_last_session = true,
    pre_save_cmds = {
      function()
        -- For barbar
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'SessionSavePre',
        })
      end
    }
  },
  keys = {
    { '<leader>jp', '<cmd>SessionSearch<cr>', desc = "session search" },
  }
}
