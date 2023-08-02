local on_attach = require('shared').on_attach

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    require('neodev').setup()

    -- vim.diagnostic.config({ virtual_text = false })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.dartls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.omnisharp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler,
      },
      cmd = {
        '/usr/bin/omnisharp',
        '--languageserver',
        '--zero-based-indices',
        '--encoding',
        'utf-8',
        '--hostPID',
        tostring(vim.fn.getpid()),
      },
      organize_imports_on_format = true,
    })

    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert {
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-u>'] = cmp.mapping.scroll_docs(4),
        ['<c-c>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' })
      },
      sources = {
        { name = 'nvim_lsp' },
        {
          name = 'luasnip',
          keyword_length = 2,
        },
      },
    })

    -- cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

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
        local group_name = 'lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name,
          { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
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
              end
            }
          end
        })
      end
    })

    -- Needed if buffers are opened by auto-session before LSP starts
    -- vim.api.nvim_command('LspStart')
  end,

  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    'Hoffs/omnisharp-extended-lsp.nvim',
    {
      'SmiteshP/nvim-navic',
      opts = {
        lsp = {
          auto_attach = false,
        }
      }
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {
        floating_window = false,
        hint_prefix = '',
        toggle_key = '<c-s>'
      },
    },
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {},
    },
    {
      'dgagn/diagflow.nvim',
      opts = {},
    }
  }
}
