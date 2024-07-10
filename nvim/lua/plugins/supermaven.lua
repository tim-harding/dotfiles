return {
  "supermaven-inc/supermaven-nvim",
  event = 'VeryLazy',
  config = function()
    local supermaven = require 'supermaven-nvim'
    supermaven.setup({
      disable_keymaps = true,
    })
  end
}
