local map = require('util').map

return {
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'nvim-lualine/lualine.nvim',

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim'
        }
      },
    },
    opts = {
      ensure_installed = nil,
      automatic_installation = true,
    }
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim'
        },
        opts = {
          lsp = { auto_attach = true }
        }
      },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(function() vim.cmd('MasonUpdate') end)
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' }
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  },

  {
    'simrat39/rust-tools.nvim',
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local rt = require('rust-tools')
          map('n', 'lh', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
        end,
        hover_actions = {
          auto_focus = true,
        }
      }
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local map = function(mode, keys, func, desc, opts)
          opts = opts or {}
          opts.buffer = bufnr
          map(mode, keys, func, desc, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, 'hunk', { expr = true })

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, 'hunk', { expr = true })

        -- Actions
        map('n', 'hs', gs.stage_hunk, 'stage')
        map('n', 'hr', gs.reset_hunk, 'reset')
        map('v', 'hs', function()
          gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, 'stage')
        map('v', 'hr', function()
          gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, 'reset')
        map('n', 'hS', gs.stage_buffer, 'stage buffer')
        map('n', 'hu', gs.undo_stage_hunk, 'undo stage')
        map('n', 'hR', gs.reset_buffer, 'reset buffer')
        map('n', 'hp', gs.preview_hunk, 'preview hunk')
        map('n', 'hb', function() gs.blame_line { full = true } end, 'blame')
        map('n', 'htb', gs.toggle_current_line_blame, 'toggle blame')
        map('n', 'hd', gs.diffthis, 'diff')
        map('n', 'hD', function() gs.diffthis('~') end, 'diff buffer')
        map('n', 'htd', gs.toggle_deleted, 'toggle deleted')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
      end,
    }
  },

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
