return {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = 'cmdline',
      },
      messages = {
        view = 'notify_send',
      },
      notify = {
        view = 'notify_send',
      },
    },
  }
}
