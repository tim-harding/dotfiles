return {
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
                -- "buffer",
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
                },
            },
        },
    },
}
