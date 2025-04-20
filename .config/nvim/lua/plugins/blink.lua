return {
  'Kaiser-Yang/blink-cmp-avante',
  {
    'saghen/blink.cmp',
    lazy = false,
    version = '*',

    init = function()
      local blink = require 'blink.cmp'
      vim.lsp.config('*', {
        capabilities = blink.get_lsp_capabilities(),
        root_markers = { '.git' },
      })
    end,

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
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
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
          'minuet',
        },
        providers = {
          snippets = {
            opts = {
              search_paths = { require('shared').snippet_path },
            },
            score_offset = 100,
          },
          lsp = {
            fallbacks = { "lazydev" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 50,
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {},
          },
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            async = true,
            timeout_ms = 3000, -- minuet.config.request_timeout * 1000
            score_offset = 150,
          },
        },
      },
    },
  },
}
