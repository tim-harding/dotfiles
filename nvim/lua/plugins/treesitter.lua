local map = require('shared').map
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      autotag = {
        enable = true,
      },
      auto_install = true,
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { 'python', 'dart' }
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<cr>',
          node_incremental = '<cr>',
          node_decremental = '<tab>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          disable = { 'dart' },
          -- Automatically jump forward to textobj.
          -- Do not have to have cursor placed inside.
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          disable = { 'dart' },
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
            [']a'] = '@parameter.inner',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
            [']A'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[a'] = '@parameter.inner',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[A'] = '@parameter.inner',
          },
        },
      },
    }

    -- TODO: Need to make this so it doesn't override ftFT repeats
    -- local ts_move = require('nvim-treesitter.textobjects.repeatable_move')
    -- map({ 'n', 'x', 'o' }, ';', ts_move.repeat_last_move_next)
    -- map({ 'n', 'x', 'o' }, ',', ts_move.repeat_last_move_previous)
  end
}
