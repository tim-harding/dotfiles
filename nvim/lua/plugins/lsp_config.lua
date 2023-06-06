return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
      config = true,
    },
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {}
    },
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' }
    },
    {
      'SmiteshP/nvim-navbuddy',
      opts = {
        lsp = {
          auto_attach = true
        }
      },
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim'
      },
    },
    {
      'jay-babu/mason-null-ls.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      opts = {
        ensure_installed = nil,
        automatic_installation = true,
      },
      dependencies = {
        {
          'jose-elias-alvarez/null-ls.nvim',
          dependencies = {
            'nvim-lua/plenary.nvim'
          }
        },
      },
    }
  },
}