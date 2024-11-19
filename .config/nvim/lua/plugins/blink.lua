return {
    'saghen/blink.cmp',
    lazy = false,
    build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        window = {
            autocomplete = {
                selection = "auto_insert",
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
        highlight = {
            use_nvim_cmp_as_default = true,
        },
    },
}
