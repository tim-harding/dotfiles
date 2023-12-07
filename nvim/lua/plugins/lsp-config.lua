local shared = require('shared')
local on_attach = shared.on_attach

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    require('neodev').setup()

    vim.diagnostic.config({ virtual_text = false })

    local diagnostic_level = vim.diagnostic.severity.WARN
    local function show_diagnostics()
      vim.diagnostic.setqflist({
        open = false,
        severity = { min = diagnostic_level, },
      })
    end

    vim.api.nvim_create_user_command('SetDiagnosticLevel', function(opts)
      local level = string.lower(opts.args)
      if level == 'warn' then
        diagnostic_level = vim.diagnostic.severity.WARN
      elseif level == 'error' then
        diagnostic_level = vim.diagnostic.severity.ERROR
      elseif level == 'hint' then
        diagnostic_level = vim.diagnostic.severity.HINT
      elseif level == 'info' then
        diagnostic_level = vim.diagnostic.severity.INFO
      end
      show_diagnostics()
    end, { nargs = 1 })

    local are_diagnostics_open = false
    shared.map('n', '<leader>t', function()
      are_diagnostics_open = not are_diagnostics_open
      if are_diagnostics_open then
        vim.cmd.copen()
        show_diagnostics()
      else
        vim.cmd.cclose()
      end
    end, 'Open workspace diagnostics')

    vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, method, result, client_id, bufnr, config)
      local default_handler = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          underline = false,
          update_in_insert = false,
        }
      )
      default_handler(err, method, result, client_id, bufnr, config)

      if are_diagnostics_open then
        show_diagnostics()
      end
    end

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

    lspconfig.zls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.ocamllsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.hls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        'haskell',
        'lhaskell',
        'cabal',
      },
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
      enabled = function()
        local context = require('cmp.config.context')
        return vim.api.nvim_get_mode().mode == 'c' or (
          not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
        )
      end,
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
        {
          name = 'nvim_lsp',
        },
        {
          name = 'luasnip',
          keyword_length = 2,
        },
      },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {}
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

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
  end,

  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'petertriho/cmp-git',
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    'Hoffs/omnisharp-extended-lsp.nvim',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
  }
}
