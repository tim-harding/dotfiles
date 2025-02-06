return {
  'rmagatti/auto-session',
  lazy = false,

  init = function()
    table.insert(vim.opt.sessionoptions, 'globals')
    table.insert(vim.opt.sessionoptions, 'options')
    table.insert(vim.opt.sessionoptions, 'localoptions')
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
  },
  keys = {
    { '<leader>jp', '<cmd>SessionSearch<cr>', desc = "session search" },
  }
}
