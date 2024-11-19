return {
    'saghen/blink.cmp',
    lazy = false,
    build = 'cargo build --release',

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
        trigger = {
            signature_help = {
                enabled = true,
            },
        },
        accept = {
            auto_brackets = {
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
    },
}
