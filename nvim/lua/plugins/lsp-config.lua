return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'Hoffs/omnisharp-extended-lsp.nvim',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    {
      'folke/neodev.nvim',
      opts = {},
    },
  },
  event = 'VeryLazy',
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )

    local simple_servers = {
      lspconfig.dartls,
      lspconfig.zls,
      lspconfig.ocamllsp,
      lspconfig.pyright,
      lspconfig.ruff_lsp,
      lspconfig.sourcekit,
      lspconfig.ruby_ls,
    }

    for _, server in ipairs(simple_servers) do
      server.setup({ capabilities = capabilities })
    end

    lspconfig.sourcekit.setup({
      capabilities = capabilities,
      cmd = {
        'xcrun',
        'sourcekit-lsp',
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            disable = { 'missing-fields' },
          },
        },
      },
    })

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
        map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
        map({ 'n', 'x' }, '<leader><leader>', vim.lsp.buf.code_action, 'code action')
      end
    })
  end,
}
