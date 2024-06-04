return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'petertriho/cmp-git',
    'saadparwaiz1/cmp_luasnip',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      build = 'make install_jsregexp',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load({
          paths = { vim.fn.stdpath('config') .. '/scissor-snippets/' },
        })
        require('luasnip').config.setup({})
      end
    },
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

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

      view = {
        entries = 'native',
      },

      window = {
        completion = {
          col_offset = 0,
          side_padding = 0,
        },
      },

      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(entry, vim_item)
          local kind = require('lspkind').cmp_format({
            mode = 'symbol',
            menu = {}, -- For Rust's ultrawide pum
          })(entry, vim_item)
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
        { name = 'lazydev' },
        {
          name = 'nvim_lsp',
          entry_filter = function(entry, _)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          end,
        },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
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
        },
      },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({ { name = 'git' } })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {},
      view = {
        entries = 'custom',
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        { { name = 'path' } },
        { { name = 'cmdline' } }
      ),
      view = {
        entries = 'custom',
      }
    })
  end
}
