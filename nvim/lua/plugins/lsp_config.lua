return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })

    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local on_attach = function(_, bufnr)
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
      map('n', 'lc', vim.lsp.buf.rename, 'change name')
      map('n', 'ld', vim.diagnostic.open_float, 'diagnostic float')
      map('n', '[d', vim.diagnostic.goto_prev, 'previous diagnostic]')
      map('n', ']d', vim.diagnostic.goto_next, 'next diagnostic')
    end

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({})
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          settings = {
            lua_ls = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              }
            }
          },
          on_attach = on_attach,
        }
      end,
    }

    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<tab>'] = cmp.mapping.select_next_item(),
        ['<s-tab>'] = cmp.mapping.select_prev_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-u>'] = cmp.mapping.scroll_docs(4),
        ['<cr>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
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
          config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
              sources = {
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.code_actions.gitsigns,
                require('typescript.extensions.null-ls.code-actions'),
              },
            })
          end,
          dependencies = {
            'nvim-lua/plenary.nvim'
          }
        },
      },
    }
  },
}
