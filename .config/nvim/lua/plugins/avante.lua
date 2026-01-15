return {
  'stevearc/dressing.nvim',
  {
    "yetone/avante.nvim",
    lazy = true,
    cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle" },
    version = false, -- Pull latest
    build = "make",
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "bedrock",
      auto_suggestions_provider = "bedrock",
      behaviour = {
        auto_suggestions = false,
      },
      windows = {
        position = 'bottom',
      },
      hints = {
        enabled = false,
      },
      providers = {
        bedrock = {
          model = "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
          aws_profile = os.getenv("AWS_PROFILE"),
          aws_region = os.getenv("AWS_REGION"),
        },
      },
    },
  }
}
