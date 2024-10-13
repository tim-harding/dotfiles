return {
  "smjonas/live-command.nvim",
  event = 'VeryLazy',
  main = 'live-command',
  opts = {
    commands = {
      Norm = { cmd = "norm" },
      G = { cmd = "g" },
    },
  },
}
