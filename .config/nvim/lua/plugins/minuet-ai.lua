return {
  'nvim-lua/plenary.nvim',
  {
    'milanglacier/minuet-ai.nvim',
    event = 'VeryLazy',
    opts = {
      throttle = 0,
      debounce = 0,
      add_single_line_entry = false,
      blink = {
        enable_auto_complete = false,
      },
      provider = 'claude',
      provider_options = {
        claude = {
          model = 'claude-3-7-sonnet-latest',
          stream = true,
        },
      },
    },
  },
}
