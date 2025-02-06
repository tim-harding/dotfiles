return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Pull latest
  build = "make",
  opts = {
    provider = "claude",
    auto_suggestions_provider = "claude",
    behaviour = {
      auto_suggestions = false,
    },
    windows = {
      position = 'bottom',
    },
  },
}
