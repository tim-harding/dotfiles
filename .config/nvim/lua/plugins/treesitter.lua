return {
  'andymass/vim-matchup',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      local configs = require 'nvim-treesitter.configs'
      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      configs.setup {
        auto_install = true,
        highlight = { enable = true },

        -- Recco from Obsidian.nvim
        ensure_installed = { 'markdown', 'markdown_inline' },

        indent = {
          enable = true,
          disable = {
            'python',
            'dart',
            'liquid',
            'swift', -- Causes the LSP to crash on completions
          }
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
              ['ae'] = '@statement.outer',
              ['ie'] = '@statement.outer', -- No inner variant
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
              [']e'] = '@statement.outer',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']S'] = '@class.outer',
              [']A'] = '@parameter.inner',
              [']C'] = '@comment.inner',
              [']I'] = '@conditional.inner',
              [']L'] = '@loop.inner',
              [']E'] = '@statement.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[s'] = '@class.outer',
              ['[a'] = '@parameter.inner',
              ['[c'] = '@comment.inner',
              ['[i'] = '@conditional.inner',
              ['[l'] = '@loop.inner',
              ['[e'] = '@statement.outer',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[S'] = '@class.outer',
              ['[A'] = '@parameter.inner',
              ['[C'] = '@comment.inner',
              ['[I'] = '@conditional.inner',
              ['[L'] = '@loop.inner',
              ['[E'] = '@statement.outer',
            },
          },

          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = "@parameter.inner",
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },

          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
          },
        },

        matchup = {
          enable = true,
        },
      }

      vim.keymap.set({ 'n', 'x' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x' }, ',', ts_repeat_move.repeat_last_move_opposite)
      vim.keymap.set({ 'n', 'x' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

      vim.api.nvim_create_user_command('TSStop', function()
        vim.treesitter.stop()
      end, {})

      vim.api.nvim_create_user_command('TSStart', function()
        vim.treesitter.start()
      end, {})

      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.o.foldenable = false
      vim.cmd('TSUpdate')
    end
  }
}
