return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'Hoffs/omnisharp-extended-lsp.nvim',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    {
      'folke/neoconf.nvim',
      opts = {}
    },
    {
      'folke/neodev.nvim',
      opts = {},
    },
  },

  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local shared = require('shared')

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
      lspconfig.ruby_lsp,
      lspconfig.gopls,
      lspconfig.marksman,
    }

    for _, server in ipairs(simple_servers) do
      server.setup({ capabilities = capabilities })
    end

    local sourcekit_cmd = { 'sourcekit-lsp' }
    if shared.is_darwin() then
      sourcekit_cmd = {
        'xcrun',
        'sourcekit-lsp',
      }
    end

    lspconfig.sourcekit.setup({
      capabilities = capabilities,
      cmd = sourcekit_cmd,
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

    ---@param bufnr integer
    local function hl_augroup_name(bufnr)
      return 'LspDocumentHighlight-' .. bufnr
    end

    local lsp_augroup = vim.api.nvim_create_augroup('UserLspConfig', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = lsp_augroup,
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local map = function(m, keys, func, desc)
          local opts = { buffer = bufnr, desc = desc }
          vim.keymap.set(m, keys, func, opts)
        end

        local highlight_augroup = vim.api.nvim_create_augroup(hl_augroup_name(bufnr), {})
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

    vim.api.nvim_create_autocmd('LspDetach', {
      group = lsp_augroup,
      callback = function(event)
        vim.api.nvim_del_augroup_by_name(hl_augroup_name(event.buf))

        local unmap = function(m, keys)
          vim.keymap.del(m, keys, { buffer = event.buf })
        end

        unmap('n', '<leader>r')
        unmap('n', 'gh')
        unmap('n', 'gs')
        unmap('n', 'gD')
        unmap({ 'n', 'x' }, '<leader><leader>')
      end
    })
  end,
}
