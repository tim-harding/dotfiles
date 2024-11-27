return {
    'saghen/blink.cmp',
    lazy = false,
    build = 'cargo build --release',
    dependencies = 'chrisgrieser/nvim-scissors',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        windows = {
            autocomplete = {
                selection = "auto_insert",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
            },
        },
        keymap = {
            preset = 'enter',
        },
        accept = {
            auto_brackets = {
                enabled = true,
            }
        },
        trigger = {
            signature_help = {
                enabled = true,
            },
        },
        highlight = {
            use_nvim_cmp_as_default = true,
        },
        fuzzy = {
            prebuilt_binaries = {
                download = false,
            },
        },
        completion = {
            enabled_providers = {
                "snippets",
                "lazydev",
                "lsp",
                "path",
                "buffer",
            },
        },
        sources = {
            providers = {
                snippets = {
                    opts = {
                        search_paths = { require('shared').snippet_path },
                    },
                },
                lsp = {
                    fallback_for = { "lazydev" },
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                },
            },
        },
    },
}
