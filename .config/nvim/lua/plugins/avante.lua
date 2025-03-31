return {
    "nvim-treesitter/nvim-treesitter", "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        build = "make",
        init = function()
            -- views can only be fully collapsed with the global statusline
            vim.opt.laststatus = 3
        end,
        config = function()
            local avante = require 'avante'

            avante.setup {
                file_selector = {provider = 'telescope'},
                behaviour = {enable_claude_text_editor_tool_mode = true}
            }

            vim.keymap.set('n', '<leader>ll', '<cmd>AvanteToggle<cr>', {})
            vim.keymap.set('n', '<leader>lf', '<cmd>AvanteFocus<cr>', {})
            vim.keymap.set('n', '<leader>ld', '<cmd>AvanteClear<cr>', {})
            vim.keymap.set('n', '<leader>lc', '<cmd>AvanteChat<cr>', {})
            vim.keymap.set('n', '<leader>le', '<cmd>AvanteEdit<cr>', {})
            vim.keymap.set('n', '<leader>ls', '<cmd>AvanteStop<cr>', {})
            vim.keymap.set('n', '<leader>lr', '<cmd>AvanteRefresh<cr>', {})
        end
    }
}
