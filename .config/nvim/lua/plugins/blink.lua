return {
  'Kaiser-Yang/blink-cmp-avante',
  {
    'saghen/blink.cmp',
    lazy = false,
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
      },
      signature = {
        enabled = true,
      },
      fuzzy = {
        prebuilt_binaries = {
          download = true,
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          }
        },
        list = {
          selection = {
            auto_insert = true,
            preselect = false,
          },
        },
      },
      sources = {
        default = {
          "snippets",
          "lazydev",
          "lsp",
          "path",
          'avante',
        },
        providers = {
          snippets = {
            opts = {
              search_paths = { require('shared').snippet_path },
            },
          },
          lsp = {
            fallbacks = { "lazydev" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {},
          },
        },
      },
    },
    config = function()
      local blink = require 'blink.cmp'
      vim.lsp.config('*', {
        capabilities = blink.get_lsp_capabilities(),
        root_markers = { '.git' },
      })
    end
  },
}
