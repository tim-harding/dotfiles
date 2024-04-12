return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },

      indent = {
        enable = true,
        disable = { 'python', 'dart' }
      },

      textobjects = {
        select = {
          enable = true,
          disable = { 'dart' },
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['as'] = '@class.outer',
            ['is'] = '@class.inner',
            ['ac'] = '@comment.outer',
            ['ic'] = '@comment.inner',
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
          },
        },

        move = {
          enable = true,
          disable = { 'dart' },
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']s'] = '@class.outer',
            [']a'] = '@parameter.inner',
            [']c'] = '@comment.inner',
            [']i'] = '@conditional.inner',
            [']l'] = '@loop.inner',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']S'] = '@class.outer',
            [']A'] = '@parameter.inner',
            [']C'] = '@comment.inner',
            [']I'] = '@conditional.inner',
            [']L'] = '@loop.inner',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[s'] = '@class.outer',
            ['[a'] = '@parameter.inner',
            ['[c'] = '@comment.inner',
            ['[i'] = '@conditional.inner',
            ['[l'] = '@loop.inner',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[S'] = '@class.outer',
            ['[A'] = '@parameter.inner',
            ['[C'] = '@comment.inner',
            ['[I'] = '@conditional.inner',
            ['[L'] = '@loop.inner',
          },
        },

        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            -- ["<leader>df"] = "@function.outer",
            -- ["<leader>dF"] = "@class.outer",
          },
        },
      },
    }

    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    vim.keymap.set({ "n", "x" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x" }, ",", ts_repeat_move.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x" }, "T", ts_repeat_move.builtin_T)

    vim.api.nvim_create_user_command('TSStop', function()
      vim.treesitter.stop()
    end, {})

    vim.api.nvim_create_user_command('TSStart', function()
      vim.treesitter.start()
    end, {})
  end
}
