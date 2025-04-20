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
      local latest = shared.latest

      vim.lsp.enable {
        'dartls',
        'zls',
        'ocamllsp',
        'pyright',
        'ruby_lsp',
        'gopls',
        'biome',
        'cssls',
        'jsonls',
        'html',
        'shopify_theme_ls',
        'glsl_analyzer',
        'clangd',
        'tinymist',
        'nixd',
        'hyprls',
        'svelte',
        'vtsls',
      }

      local ts_dir = latest('~/.bun/install/cache/typescript')
      local tsdk_dir = vim.fs.joinpath(ts_dir, 'lib')

      -- Vue setup info:
      -- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
      vim.lsp.config('volar', {
        init_options = {
          typescript = {
            tsdk = tsdk_dir,
          },
          vue = {
            hybridMode = true,
          },
        },
      })

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
        vim.lsp.config('sourcekit', {
          cmd = sourcekit_command(),
        })
      end

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
              globals = { 'vim' },
            },
            diagnostics = {
              disable = { 'missing-fields' },
            },
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })

      vim.lsp.config('hls', {
        filetypes = {
          'haskell',
          'lhaskell',
          'cabal',
        },
      })

      if false then
        if shared.is_darwin() then
          vim.lsp.config('metals', {
            cmd_end = {
              JAVA_HOME = '/Library/Java/JavaVirtualMachines/zulu-24.jdk/Contents/Home/',
            },
            settings = {
              metals = {
                javaHome = '/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home/',
              },
            },
          })
        elseif shared.is_linux() then
          vim.lsp.config('metals', {})
        end
      end

      local function omnisharp_path()
        if shared.is_linux() then
          return '/usr/bin/omnisharp'
        elseif shared.is_darwin() then
          return '/opt/homebrew/bin/omnisharp'
        end
      end

      local omnisharp_extended = require 'omnisharp_extended'
      vim.lsp.config('omnisharp', {
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
      })

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

      vim.lsp.config('cls', {})

      ---@param bufnr integer
      local function hl_augroup_name(bufnr)
        return 'lsp-document-highlight-' .. bufnr
      end

      ---@param bufnr integer
      local function hl_augroup(bufnr)
        return vim.api.nvim_create_augroup(hl_augroup_name(bufnr), { clear = false })
      end

      local lsp_augroup = vim.api.nvim_create_augroup('lsp-config', {})
      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_augroup,
        callback = function(event)
          vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"

          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client == nil then
            return
          end

          if client:supports_method('textDocument/foldingRange', bufnr) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
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

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(detach_event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = group, buffer = detach_event.buf }
              end,
            })
          end

          local function map(m, keys, func, desc)
            vim.keymap.set(m, keys, func, { buffer = bufnr, desc = desc })
          end

          local is_inlay_supported = client:supports_method('textDocument/inlayHint')
          vim.lsp.inlay_hint.enable(is_inlay_supported, { bufnr = bufnr })

          local function toggle_inlay_hints()
            vim.lsp.inlay_hint.enable(
              is_inlay_supported and not vim.lsp.inlay_hint.is_enabled(),
              { bufnr = bufnr }
            )
          end
          map('n', '<leader>i', toggle_inlay_hints, 'toggle inlay hints')

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
