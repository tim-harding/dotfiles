return {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true,
      },
      cmdline = {
        view = 'cmdline',
      },
      messages = {
        view = 'mini',
        view_warn = 'mini',
        view_error = 'mini',
        view_search = false,
      },
      notify = {
        view = 'mini',
      },
    },
  }
}
