local map = require('util').map

return {
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'nvim-lualine/lualine.nvim',

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = true
      },
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {}
      },
    },
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      -- latte, frappe, macchiato, mocha
      flavour = 'frappe',
      integrations = {
        hop = true,
      }
    }
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  'sainnhe/everforest',
  'shaunsingh/nord.nvim',

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
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
    end
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        opts = {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
          layouts = {
            {
              elements = {
                {
                  id = 'stacks',
                  size = 0.33
                },
                {
                  id = 'scopes',
                  size = 0.67
                },
              },
              position = 'top',
              size = 15,
            },
            {
              elements = {
                {
                  id = 'console',
                  size = 1
                }
              },
              position = 'bottom',
              size = 4,
            },
            {
              elements = {
                {
                  id = 'breakpoints',
                  size = 0.5
                },
                {
                  id = 'watches',
                  size = 0.5
                }
              },
              position = 'left',
              size = 1,
            },
          },
        },
      },

      'williamboman/mason.nvim',

      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          automatic_setup = true,
          handlers = {},
        }
      },

      -- Add language-specific debuggers here
      {
        'leoluz/nvim-dap-go',
        config = true,
      },
    }
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2',
    opts = {
      keys = 'tnserigmfuplwybjdhcvkaoqxz',
    }
  },
}
