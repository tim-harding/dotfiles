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
      opts = {
        library = {
          plugins = {
            'neotest',
          },
          types = true,
        }
      },
    },
  },

  config = function()
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local shared = require 'shared'

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
      lspconfig.sourcekit,
      lspconfig.ruby_lsp,
      lspconfig.gopls,
      lspconfig.marksman,
      lspconfig.typst_lsp,
    }

    for _, server in ipairs(simple_servers) do
      server.setup({ capabilities = capabilities })
    end

    local function sourcekit_command()
      if shared.is_linux() then
        return { 'sourcekit-lsp' }
      elseif shared.is_darwin() then
        return {
          'xcrun',
          'sourcekit-lsp',
        }
      end
    end

    lspconfig.sourcekit.setup {
      capabilities = capabilities,
      cmd = sourcekit_command(),
    }

    lspconfig.lua_ls.setup {
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
    }

    lspconfig.hls.setup {
      capabilities = capabilities,
      filetypes = {
        'haskell',
        'lhaskell',
        'cabal',
      },
    }

    lspconfig.omnisharp.setup {
      capabilities = capabilities,
      handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
        ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
        ['textDocument/references'] = require('omnisharp_extended').references_handler,
        ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
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
    }

    vim.filetype.add {
      extension = {
        chpl = 'chapel',
      }
    }

    configs.cls = {
      default_config = {
        cmd = { 'chpl-language-server' },
        filetypes = { 'chapel' },
        autostart = true,
        single_file_support = true,
        root_dir = lspconfig.util.find_git_ancestor,
        settings = {},
      },
    }

    lspconfig.cls.setup {}

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
