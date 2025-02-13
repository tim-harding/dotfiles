return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  'onsails/lspkind.nvim',
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = { 'saghen/blink.cmp' },

    config = function()
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'
      local shared = require 'shared'

      lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      end)

      local simple_servers = {
        lspconfig.dartls,
        lspconfig.zls,
        lspconfig.ocamllsp,
        lspconfig.pyright,
        lspconfig.ruby_lsp,
        lspconfig.gopls,
        lspconfig.biome,
        lspconfig.cssls,
        lspconfig.jsonls,
        lspconfig.html,
        lspconfig.shopify_theme_ls,
        lspconfig.glsl_analyzer,
        lspconfig.clangd,
        lspconfig.tinymist,
        lspconfig.nixd,
        lspconfig.hyprls,
      }

      for _, server in ipairs(simple_servers) do
        server.setup({})
      end

      -- Vue setup info:
      -- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration

      local function latest(path)
        local expanded = vim.fn.expand(path)
        local entries = {}
        for name, type in vim.fs.dir(expanded) do
          if type == 'link' or type == 'directory' then
            table.insert(entries, name)
          end
        end
        table.sort(entries)
        return vim.fn.resolve(vim.fs.joinpath(expanded, entries[#entries]))
      end

      local ts_languages = lspconfig.vtsls.config_def.default_config.filetypes
      table.insert(ts_languages, 'vue')
      table.insert(ts_languages, 'svelte')

      local plugin_vue = latest('~/.bun/install/cache/@vue/typescript-plugin')
      local plugin_svelte = latest('~/.bun/install/cache/typescript-svelte-plugin')

      lspconfig.svelte.setup {
        settings = {
          svelte = {
            plugin = {
              typescript = {
                enable = false,
              },
            },
          },
        },
      }

      lspconfig.vtsls.setup {
        filetypes = ts_languages,
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = plugin_vue,
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
                {
                  name = "typescript-svelte-plugin",
                  location = plugin_svelte,
                  languages = { "svelte" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      }

      local ts_dir = latest('~/.bun/install/cache/typescript')
      local tsdk_dir = vim.fs.joinpath(ts_dir, 'lib')

      local volar_languages = lspconfig.volar.config_def.default_config.filetypes
      table.insert(volar_languages, 'markdown')

      lspconfig.volar.setup {
        filetypes = volar_languages,
        init_options = {
          typescript = {
            tsdk = tsdk_dir,
          },
          vue = {
            hybridMode = true,
          },
        },
      }

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

      -- Disabling for now. I only want sourcekit for Swift but it is
      -- conflicting with clandg for cpp files.
      if shared.is_darwin() then
        lspconfig.sourcekit.setup {
          cmd = sourcekit_command(),
        }
      end

      lspconfig.lua_ls.setup {
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
        -- capabilities = vim.tbl_deep_extend('force', {}, -- todo: Should be the existing server capabilities
        -- {
        --   workspace = {
        --     didChangeWatchedFiles = {
        --       dynamicRegistration = true,
        --     },
        --   },
        -- }),
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

          if client:supports_method('textDocument/documentHighlight', bufnr) then
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

          vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"

          local tb = require('telescope.builtin')
          map('n', 'gr', tb.lsp_references, 'goto reference')
          map('n', 'gd', tb.lsp_definitions, 'goto definition')
          map('n', 'gt', tb.lsp_type_definitions, 'goto type definition')
          map('n', 'gi', tb.lsp_implementations, 'goto implementation')

          -- local fzf = require('fzf-lua')
          -- map('n', 'gr', fzf.lsp_references, 'goto reference')
          -- map('n', 'gd', fzf.lsp_definitions, 'goto definition')
          -- map('n', 'gt', fzf.lsp_typedefs, 'goto type definition')
          -- map('n', 'gi', fzf.lsp_implementations, 'goto implementation')

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
