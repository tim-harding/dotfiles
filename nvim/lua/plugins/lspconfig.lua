return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  'onsails/lspkind.nvim',
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',

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
        lspconfig.ruby_lsp,
        lspconfig.gopls,
        lspconfig.typst_lsp,
        lspconfig.biome,
        lspconfig.cssls,
        lspconfig.jsonls,
        lspconfig.html,
        lspconfig.tsserver,
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

      local function omnisharp_path()
        if shared.is_linux() then
          return '/usr/bin/omnisharp'
        elseif shared.is_darwin() then
          return '/opt/homebrew/bin/omnisharp'
        end
      end

      local omnisharp_extended = require 'omnisharp_extended'
      lspconfig.omnisharp.setup {
        capabilities = vim.tbl_deep_extend('force', capabilities, {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }),
        handlers = {
          ['textDocument/definition'] = omnisharp_extended.definition_handler,
          ['textDocument/typeDefinition'] = omnisharp_extended.type_definition_handler,
          ['textDocument/references'] = omnisharp_extended.references_handler,
          ['textDocument/implementation'] = omnisharp_extended.implementation_handler,
        },
        cmd = {
          omnisharp_path(),
          '--languageserver',
          '--zero-based-indices',
          '--encoding',
          'utf-8',
          '--hostPID',
          tostring(vim.fn.getpid()),
        },
        organize_imports_on_format = true,
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

      ---@param bufnr integer
      local function hl_augroup(bufnr)
        return vim.api.nvim_create_augroup(hl_augroup_name(bufnr), { clear = false })
      end

      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
      shared.map('n', '<leader>i', toggle_inlay_hints, 'toggle inlay hints')

      local lsp_augroup = vim.api.nvim_create_augroup('UserLspConfig', {})
      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_augroup,
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client == nil then
            return
          end

          local function map(m, keys, func, desc)
            vim.keymap.set(m, keys, func, { buffer = bufnr, desc = desc })
          end

          if client.supports_method('textDocument/documentHighlight', { bufnr = bufnr }) then
            local group = hl_augroup(bufnr)

            vim.api.nvim_create_autocmd({
              'CursorHold',
            }, {
              callback = vim.lsp.buf.document_highlight,
              buffer = bufnr,
              group = group,
            })

            vim.api.nvim_create_autocmd({
              'CursorMoved',
              'InsertEnter',
            }, {
              callback = vim.lsp.buf.clear_references,
              buffer = bufnr,
              group = group,
            })
          end

          map('n', '<leader>r', vim.lsp.buf.rename, 'rename')
          map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
          map('n', 'gh', vim.lsp.buf.hover, 'hover')
          map({ 'n', 'x' }, '<leader><leader>', vim.lsp.buf.code_action, 'code action')
        end
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = lsp_augroup,
        callback = function(event)
          pcall(vim.api.nvim_del_augroup_by_name, hl_augroup_name(event.buf))

          local function unmap(m, keys)
            pcall(vim.keymap.del, m, keys, { buffer = event.buf })
          end

          unmap('n', '<leader>r')
          unmap('n', 'gD')
          unmap('n', 'gh')
          unmap({ 'n', 'x' }, '<leader><leader>')
        end
      })
    end,
  }
}
