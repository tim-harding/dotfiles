return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  config = function()
    local supermaven = require 'supermaven-nvim'
    local api = require 'supermaven-nvim.api'
    supermaven.setup({
      keymaps = {
        accept_suggestion = "<c-a>",
        accept_word = "<c-s-a>",
        clear_suggestion = "<m-s-a>",
      },
    })
    api.stop()
    vim.keymap.set({ 'n', 'i' }, '<m-a>', api.toggle, {})
  end,
}
