-- vim.opt works like :set and generalizes vim.o, vim.bo, and vim.wo
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.scrolloff = 3
vim.opt.cmdheight = 0
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.cursorline = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- If config = true, call setup without arguments
-- If opts = {...}, call setup with the given opts
require('lazy').setup({
  'tpope/vim-sleuth',
  'simrat39/rust-tools.nvim',
  'windwp/nvim-ts-autotag',
  'nvim-lualine/lualine.nvim',

  {
    'nvim-tree/nvim-tree.lua',
    opts = {}
  },

  {
    'folke/which-key.nvim',
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  {
    'windwp/nvim-autopairs',
    opts = {}
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    }
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  },

  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = 'Update',
            group = 'Main',
            action = function()
              require('lazy').update()
              require('mason.api.command').MasonUpdate()
            end,
            key = 'u',
          }
        },
        project = {
          enable = false,
        },
        mru = {
          limit = 20,
        },
        footer = {},
      }
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>p', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[p]review hunk' })
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
      {
        'folke/neodev.nvim',
        opts = {
          library = {
            plugins = { "nvim-dap-ui" },
            types = true
          },
        }
      },
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
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }
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
}, {})

vim.cmd.colorscheme 'catppuccin'

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')



-------------
-- Lualine --
-------------

local function macro_recording_section()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

local lualine = require('lualine')
lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      'filename',
      {
        'macro-recording',
        fmt = macro_recording_section,
      }
    }
  }
}

local refresh_lualine = function()
  lualine.refresh({
    place = { 'statusline' },
  })
end

local lualine_recording = vim.api.nvim_create_augroup('LualineRecording', { clear = true })
vim.api.nvim_create_autocmd('RecordingEnter', {
  group = lualine_recording,
  callback = refresh_lualine,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  group = lualine_recording,
  callback = function()
    -- Need to wait a short time for the recording to be purged
    local timeout_ms = 50
    local no_repeat = 0
    local scheduled_refresh_lualine = vim.schedule_wrap(refresh_lualine)
    local timer = vim.loop.new_timer()
    timer:start(timeout_ms, no_repeat, scheduled_refresh_lualine)
  end,
})
-----------------


-----------------
-- Completions --
-----------------
vim.diagnostic.config({
  virtual_text = false,
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  local map = function(m, lhs, rhs)
    local opts = { buffer = bufnr }
    vim.keymap.set(m, lhs, rhs, opts)
  end

  -- LSP actions
  map('n', 'K', vim.lsp.buf.hover)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'go', vim.lsp.buf.type_definition)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', 'gs', vim.lsp.buf.signature_help)
  map('n', '<F2>', vim.lsp.buf.rename)
  map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
  map('n', 'la', vim.lsp.buf.code_action)
  map('x', 'la', function() vim.lsp.buf.range_code_action() end)
  map('n', 'lr', vim.lsp.buf.rename)

  -- -- Diagnostics
  map('n', 'gl', vim.diagnostic.open_float)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = {'lua'},
    ['rust_analyzer'] = {'rust'},
    -- ['null-ls'] = {'javascript', 'typescript'},
  }
})

-- Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer',  keyword_length = 5 },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
---------------------


------------------
-- Autocommands --
------------------
local set_indent_group = vim.api.nvim_create_augroup('SetIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = set_indent_group,
  pattern = { 'html', 'javascript', 'lua' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
------------------



local dap = require 'dap'
local dapui = require 'dapui'
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close


require('nvim-treesitter.configs').setup {
  autotag = {
    enable = true,
  },
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}



vim.keymap.set('n', 'h', '')
vim.keymap.set('n', 'j', ':WhichKey j<cr>')
vim.keymap.set('n', 'k', '')
vim.keymap.set('n', 'l', '')

vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<cr>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>t', ':TroubleToggle<cr>', { silent = true, noremap = true })
vim.keymap.set('n', ']q', function() require('trouble').next({ skip_groups = true, jump = true }) end,
  { silent = true, noremap = true })
vim.keymap.set('n', '[q', function() require('trouble').previous({ skip_groups = true, jump = true }) end,
  { silent = true, noremap = true })

-- TODO: Try to combine these with the Trouble commands:
-- vim.keymap.set('n', '[q', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
-- vim.keymap.set('n', ']q', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<C-S-v>', '"+p')
vim.keymap.set('i', '<C-S-v>', '<esc>"+pi')
vim.keymap.set('n', '<C-Tab>', ':bn<cr>', { silent = true })
vim.keymap.set('n', '<C-S-Tab>', ':bp<cr>', { silent = true })
vim.keymap.set('n', '<leader>c', ':source ~/.config/nvim/init.lua<cr>', { silent = true, desc = '[c]onfig reload' })

vim.keymap.set('n', 'h', ':HopWord<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 's', ':HopChar2<cr>', { noremap = true, silent = true })

vim.keymap.set('n', 'jr', require('telescope.builtin').oldfiles, { desc = '[f]ind [r]ecent' })
vim.keymap.set('n', 'jf', require('telescope.builtin').git_files, { desc = '[j]ump [f]ile' })
vim.keymap.set('n', 'jh', require('telescope.builtin').help_tags, { desc = '[j]ump [h]elp' })
vim.keymap.set('n', 'jd', require('telescope.builtin').diagnostics, { desc = '[j]ump [d]iagnostics' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Search current buffer' })

vim.keymap.set('n', '<C-Left>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.terminate)
vim.keymap.set('n', '<F9>', dap.step_into)
vim.keymap.set('n', '<F6>', dap.step_over)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = '[b]reakpoint toggle' })
vim.keymap.set('n', '<F7>', dapui.toggle)
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = '[B]reakpoint condition' })

vim.keymap.set('n', '<leader>s', ':w<cr>', { silent = true, noremap = true })
