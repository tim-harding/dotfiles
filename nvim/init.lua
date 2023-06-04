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
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.shortmess = 'aoOstTIFcC'

-- Want to enable but too many 'Press Enter to continue' messages for now
-- vim.opt.cmdheight = 0

vim.loader.enable()

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

local map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end

require('lazy').setup({
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'simrat39/rust-tools.nvim',
  'windwp/nvim-ts-autotag',
  'nvim-lualine/lualine.nvim',

  {
    'nvim-tree/nvim-tree.lua',
    opts = {}
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
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
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
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
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' }
      },
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
          gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
        end, 'stage')
        map('v', 'hr', function()
          gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
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
  local map = function(m, keys, func, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, keys, func, opts)
  end

  map('n', 'K', vim.lsp.buf.hover, 'hover')
  map('n', 'gd', vim.lsp.buf.definition, 'definition')
  map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
  map('n', 'gi', vim.lsp.buf.implementation, 'implementation')
  map('n', 'gt', vim.lsp.buf.type_definition, 'type definition')
  map('n', 'gr', vim.lsp.buf.references, 'references')
  map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')
  map('n', 'la', vim.lsp.buf.code_action, 'code action')
  map('x', 'la', function() vim.lsp.buf.range_code_action() end, 'code action')
  map('n', 'lr', vim.lsp.buf.rename, 'rename')

  map('n', 'ld', vim.diagnostic.open_float, 'diagnostic float')
  map('n', '[d', vim.diagnostic.goto_prev, 'previous diagnostic]')
  map('n', ']d', vim.diagnostic.goto_next, 'next diagnostic')
end)

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['rust_analyzer'] = { 'rust' },
    ['typescript-language-server'] = { 'javascript', 'typescript', 'jsx' },
    ['null-ls'] = { 'html', 'css', 'scss', 'json', 'yaml', 'markdown' },
  }
})

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
    -- { name = 'buffer',  keyword_length = 5 },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
---------------------



-------------
-- Null LS --
-------------
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns,
  },
})
-------------



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



---------
-- DAP --
---------
local dap = require 'dap'
local dapui = require 'dapui'
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
---------



----------------
-- Treesitter --
----------------
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
----------------



-------------
-- Keymaps --
-------------
local whichkey = require('which-key')
map('n', 'h', function() whichkey.show('h', { mode = 'n', auto = true }) end)
map('n', 'hh', '<nop>')
map('n', 'j', function() whichkey.show('j', { mode = 'n', auto = true }) end)
map('n', 'jj', '<nop>')
map('n', 'k', function() whichkey.show('k', { mode = 'n', auto = true }) end)
map('n', 'kk', '<nop>')
map('n', 'l', function() whichkey.show('l', { mode = 'n', auto = true }) end)
map('n', 'll', '<nop>')

map('n', 'hc', ':Git commit --quiet<cr>', 'commit')
map('n', 'ha', ':Git commit --quiet --amend --no-edit<cr>', 'amend')

map('n', '<leader>f', ':NvimTreeToggle<cr>')

local trouble = require('trouble')
map('n', '<leader>t', ':TroubleToggle<cr>', 'toggle trouble')
map('n', ']q', function()
  trouble.next({
    skip_groups = true,
    jump = true
  })
end, 'trouble diagnostic')
map('n', '[q', function()
  trouble.previous({
    skip_groups = true,
    jump = true
  })
end, 'trouble diagnostic')

map('n', '<C-S-v>', '"+p')
map('i', '<C-S-v>', '<esc>"+pi')
map('n', '<leader>c', ':source ~/.config/nvim/init.lua<cr>', 'reload config')

map('n', 's', ':HopChar2<cr>')
map('n', 'jj', ':HopWord<cr>', 'hop word')

map('n', 'jr', require('telescope.builtin').oldfiles, 'recent')
map('n', 'jf', require('telescope.builtin').git_files, 'file')
map('n', 'jh', require('telescope.builtin').help_tags, 'help')
map('n', 'jd', require('telescope.builtin').diagnostics, 'diagnostics')
map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, 'search buffer')

map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')

map('n', '<F5>', dap.continue)
map('n', '<F1>', dap.terminate)
map('n', '<F10>', dap.step_over)
map('n', '<F11>', dap.step_into)
map('n', '<F12>', dap.step_out)
map('n', '<leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
map('n', '<F9>', dapui.toggle)
map('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, 'breakpoint condition')

map('n', '<leader>s', ':w<cr>', 'save')
