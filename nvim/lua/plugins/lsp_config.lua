local on_attach = require('shared').on_attach

local set_up_autoformat = function()
  local format_is_enabled = true
  vim.api.nvim_create_user_command('ToggleAutoformat', function()
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

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    callback = function(args)
      local client_id = args.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)
      local bufnr = args.buf

      if not client.server_capabilities.documentFormattingProvider then
        return
      end

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
end

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    require('neodev').setup()

    vim.diagnostic.config({
      virtual_text = false,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local server_settings = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        }
      }
    }

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({})
    mason_lspconfig.setup_handlers {
      function(server_name)
        if server_name ~= 'tsserver' then
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = server_settings,
            on_attach = on_attach,
          }
        end
      end,
    }

    local cmp = require('cmp')
    local luasnip = require('luasnip')
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

    set_up_autoformat()
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
                require('typescript.extensions.null-ls.code-actions'),
              },
            })
          end,
          dependencies = {
            'nvim-lua/plenary.nvim'
          }
        },
      },
    },
    {
      'ray-x/lsp_signature.nvim',
      opts = {},
    }
  },
}
