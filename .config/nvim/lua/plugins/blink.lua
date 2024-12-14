return {
    'saghen/blink.cmp',
    lazy = false,
    build = 'cargo build --release',
    dependencies = 'chrisgrieser/nvim-scissors',

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
                download = false,
            },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                update_delay_ms = 0,
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                }
            },
            list = {
                selection = "auto_insert",
            },
        },
        sources = {
            default = {
                "snippets",
                "lazydev",
                "lsp",
                "path",
                "buffer",
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
