return {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope-dap.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'alduraibi/telescope-glyph.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    build = 'make',
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = 'VeryLazy',

    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local tb = require('telescope.builtin')
      local themes = require('telescope.themes')
      local map = require('shared').map

      telescope.setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = {
              padding = 0,
            },
            height = {
              padding = 0,
            },
            mirror = true,
            prompt_position = 'top',
          },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-h>'] = 'which_key',
            }
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
          ['ui-select'] = {
            themes.get_dropdown(),
          },
          glyph = {
            action = function(glyph)
              vim.api.nvim_put({ glyph.value }, 'c', false, true)
            end,
          },
        },

        pickers = {
          live_grep = {
            additional_args = {
              '--hidden',
              '--glob',
              '!.git',
              '--glob',
              '!.metals',
            },
          },
          git_files = {
            show_untracked = true,
          },
          find_files = {
            find_command = {
              'fd',
              '--type',
              'file',
              '--type',
              'directory',
              '--type',
              'symlink',
              '--color=never',
              '--hidden',
              '--exclude',
              '.git',
            },
          },
        },
      })

      telescope.load_extension('fzf')
      telescope.load_extension('dap')
      telescope.load_extension('ui-select')
      telescope.load_extension('metals')
      telescope.load_extension('glyph')

      map('n', '<leader>jj', tb.find_files, 'files')
      map('n', '<leader>jg', tb.git_files, 'git files')
      map('n', '<leader>jo', tb.oldfiles, 'oldfiles')
      map('n', '<leader>jh', tb.help_tags, 'help')
      map('n', '<leader>jr', tb.live_grep, 'ripgrep project')
      map('n', '<leader>jq', tb.quickfix, 'quickfix')
      map('n', '<leader>js', tb.lsp_dynamic_workspace_symbols, 'find project symbol')
      map('n', '<leader>jd', function()
        tb.find_files({ cwd = '~/dotfiles' })
      end, 'Dotfiles')
    end
  }
}
