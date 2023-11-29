return {
  "smjonas/live-command.nvim",
  event = 'VeryLazy',
  config = function()
    -- Using opts gives warning because it tries to require 'live_command'
    require('live-command').setup({
      commands = {
        Norm = { cmd = "norm" },
        G = { cmd = "g" },
      },
    })
  end,
}
