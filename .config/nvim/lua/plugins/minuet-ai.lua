return {
  'nvim-lua/plenary.nvim',
  {
    'milanglacier/minuet-ai.nvim',
    event = 'VeryLazy',
    opts = {
      n_completions = 1,
      virtualtext = {
        keymap = {
          accept = '<s-tab>',
          next = '<c-tab>',
          dismiss = '<m-tab>',
        },
      },
      provider = 'claude',
      provider_options = {
        claude = {
          model = 'claude-3-5-sonnet-latest',
        },
      },
    },
  },
}
