function test(things, stuff)

end

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    require('neodev').setup()
    local shared = require('shared')

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

    local simple_servers = {
      lspconfig.lua_ls,
      lspconfig.dartls,
      lspconfig.zls,
      lspconfig.ocamllsp,
      lspconfig.pyright,
      lspconfig.ruff_lsp,
    }

    for _, server in ipairs(simple_servers) do
      server.setup({ capabilities = capabilities })
    end

    lspconfig.hls.setup({
      capabilities = capabilities,
      filetypes = {
        'haskell',
        'lhaskell',
        'cabal',
      },
    })

    lspconfig.omnisharp.setup({
      capabilities = capabilities,
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

    local highlight_augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client.server_capabilities.completionProvider then
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client.server_capabilities.definitionProvider then
          vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        local map = function(m, keys, func, desc)
          local opts = { buffer = bufnr, desc = desc }
          vim.keymap.set(m, keys, func, opts)
        end

        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = highlight_augroup,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorHoldI' }, {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = highlight_augroup,
          })
        end

        map('n', '<leader>r', vim.lsp.buf.rename, 'rename')
        map('n', 'gh', vim.lsp.buf.hover, 'hover')
        map('n', 'gs', vim.lsp.buf.signature_help, 'show signature')
        map({ 'n', 'x' }, '<leader><leader>', vim.lsp.buf.code_action, 'code action')
        map('n', 'k', vim.diagnostic.goto_next, 'next diagnostic')
        map('n', 'K', vim.diagnostic.goto_prev, 'previous diagnostic')
      end
    })

    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { vim.fn.stdpath('config') .. '/scissor-snippets/' },
    })
    luasnip.config.setup({})

    cmp.setup({
      enabled = function()
        local context = require('cmp.config.context')
        return vim.api.nvim_get_mode().mode == 'c' or (
          not context.in_treesitter_capture('comment')
          and not context.in_syntax_group('Comment')
        )
      end,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },

      window = {
        completion = {
          col_offset = -3,
          side_padding = 0,
        },
      },

      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(entry, vim_item)
          local kind = require('lspkind').cmp_format({
            mode = 'symbol',
          })(entry, vim_item)
          kind.kind = ' ' .. kind.kind .. ' '
          return kind
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<Cr>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
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
          entry_filter = function(entry, ctx)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          end,
        },
        { name = 'luasnip' },
        {
          name = 'emoji',
          option = {
            insert = true,
          }
        },
        {
          name = 'omni',
          option = {
            disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' },
          }
        }
      },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({ { name = 'git' } })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {}
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
    })

    -- TODO: Doesn't play nice with functional languages
    -- cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

    local format_is_enabled = true
    vim.api.nvim_create_user_command('AutoformatToggle', function()
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
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-emoji',
    'petertriho/cmp-git',
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    'Hoffs/omnisharp-extended-lsp.nvim',
    'onsails/lspkind.nvim',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
  }
}
