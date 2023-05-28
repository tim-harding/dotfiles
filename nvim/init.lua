vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.scrolloff = 3
vim.o.cmdheight = 0
vim.o.wrap = true
vim.wo.signcolumn = 'yes'
vim.wo.number = true
vim.opt.swapfile = false

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
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  "simrat39/rust-tools.nvim",
  "windwp/nvim-ts-autotag",

  {
    "nvim-tree/nvim-tree.lua",
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
    "windwp/nvim-autopairs",
    opts = {}
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
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
        vim.keymap.set('n', '<leader>p', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[p]review hunk' })
      end,
    }
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        config = true
      },
      'williamboman/mason-lspconfig.nvim',
      {
        'folke/neodev.nvim',
        config = true,
      },
      {
        'j-hui/fidget.nvim',
        opts = {}
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- latte, frappe, macchiato, mocha
      flavour = "frappe",
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
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      -- Add language-specific debuggers here
      {
        'leoluz/nvim-dap-go',
        config = true,
      },
    }
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    opts = {
      keys = "tnserigmfuplwybjdhcvkaoqxz",
    }
  },
}, {})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.diagnostic.config({
  virtual_text = false,
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

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

--  Runs whenever an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')

  nmap('lD', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('lr', vim.lsp.buf.rename, '[r]ename')
  nmap('la', vim.lsp.buf.code_action, 'Code [a]ction')
  nmap('lk', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('js', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[f]ind [s]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Language servers config
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  -- Default
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,

  ["rust_analyzer"] = function()
    local rt = require('rust-tools')

    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.1/'
    local codelldb = extension_path .. 'adapter/codelldb'
    local liblldb = extension_path .. 'lldb/lib/liblldb.so'

    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          on_attach(_, bufnr)
          vim.keymap.set("n", "<leader>h", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "[h]over actions" })
        end
      },
      -- dap = {
      --   adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb, liblldb)
      -- },
      tools = {
        hover_actions = {
          auto_focus = true,
        }
      }
    })
  end,
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Insert `(` after selecting function
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_setup = true,
  ensure_installed = {
    'delve',
  },
  handlers = {},
}

dapui.setup {
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
      disconnect = "⏏",
    },
  },
  layouts = {
    {
      elements = {
        {
          id = "stacks",
          size = 0.33
        },
        {
          id = "scopes",
          size = 0.67
        },
      },
      position = "top",
      size = 15,
    },
    {
      elements = {
        {
          id = "console",
          size = 1
        }
      },
      position = "bottom",
      size = 4,
    },
    {
      elements = {
        {
          id = "breakpoints",
          size = 0.5
        },
        {
          id = "watches",
          size = 0.5
        }
      },
      position = "left",
      size = 1,
    },
  },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- :KickstartFormatToggle toggles autoformatting on or off
local format_is_enabled = true
vim.api.nvim_create_user_command('KickstartFormatToggle', function()
  format_is_enabled = not format_is_enabled
  print('Setting autoformatting to: ' .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
-- We need one augroup per client to make sure that multiple clients
-- can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
  if not _augroups[client.id] then
    local group_name = 'kickstart-lsp-format-' .. client.name
    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
    _augroups[client.id] = id
  end
  return _augroups[client.id]
end

-- Run whenever an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    if not client.server_capabilities.documentFormattingProvider then
      return
    end

    -- Autoformat autocommand
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = get_augroup(client),
      buffer = bufnr,
      callback = function()
        if not format_is_enabled then
          return
        end

        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        }
      end,
    })
  end,
})

vim.cmd.colorscheme 'catppuccin'

vim.keymap.set('n', 'h', '')
vim.keymap.set('n', 'j', ":WhichKey j<cr>")
vim.keymap.set('n', 'k', '')
vim.keymap.set('n', 'l', '')

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>t", ":TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "]q", function() require("trouble").next({ skip_groups = true, jump = true }) end,
  { silent = true, noremap = true })
vim.keymap.set("n", "[q", function() require("trouble").previous({ skip_groups = true, jump = true }) end,
  { silent = true, noremap = true })

-- TODO: Try to combine these with the Trouble commands:
-- vim.keymap.set('n', '[q', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
-- vim.keymap.set('n', ']q', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("n", "<C-S-v>", '"+p')
vim.keymap.set("i", "<C-S-v>", '<esc>"+pi')
vim.keymap.set("n", "<C-Tab>", ":bn<cr>", { silent = true })
vim.keymap.set("n", "<C-S-Tab>", ":bp<cr>", { silent = true })
vim.keymap.set("n", "<leader>c", ":source ~/.config/nvim/init.lua<cr>", { silent = true, desc = "[c]onfig reload" })

vim.keymap.set("n", "h", ":HopWord<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "s", ":HopChar2<cr>", { noremap = true, silent = true })

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
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "[b]reakpoint toggle" })
vim.keymap.set("n", "<F7>", dapui.toggle)
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = "[B]reakpoint condition" })
