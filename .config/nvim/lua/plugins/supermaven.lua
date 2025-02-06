return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  config = function()
    local supermaven = require 'supermaven-nvim'
    local api = require 'supermaven-nvim.api'
    supermaven.setup({
      keymaps = {
        accept_suggestion = "<c-a>",
        clear_suggestion = "<m-a>",
        accept_word = "<c-s-a>",
      },
    })
    api.stop()
    vim.keymap.set('n', '<leader>v', api.toggle, {})
  end,
}
