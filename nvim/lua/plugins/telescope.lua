return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    telescope.setup {
      defaults = {
        layout_strategy = 'vertical',
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<esc>'] = actions.close,
          },
        },
      },
    }
    telescope.load_extension('fzf')
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
}
