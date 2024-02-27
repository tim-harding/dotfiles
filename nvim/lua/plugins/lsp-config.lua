return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim',
    'Hoffs/omnisharp-extended-lsp.nvim',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  event = 'VeryLazy',
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = cmp_nvim_lsp.default_capabilities()
    require('neodev').setup()

    local simple_servers = {
      lspconfig.lua_ls,
      lspconfig.dartls,
      lspconfig.zls,
      lspconfig.ocamllsp,
      lspconfig.pyright,
      lspconfig.ruff_lsp,
      lspconfig.rust_analyzer,
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
}
