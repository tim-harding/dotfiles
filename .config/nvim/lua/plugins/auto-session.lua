-- When updating nvim, may need to
-- rm -rf ~/.local/share/nvim/auto_session/ ~/.local/share/nvim/sessions/
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
    auto_restore = true,
    auto_restore_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
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
