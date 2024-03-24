return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x', -- Release branch
  event = 'VeryLazy',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
  },

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
          width = 0.8,
          mirror = true,
          prompt_position = 'top',
        },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<esc>'] = actions.close,
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
      },

      pickers = {
        find_files = {
          find_command = {
            'fd',
            '--type',
            'file',
            '--color=never',
            '--hidden',
          },
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    telescope.load_extension('dap')
    telescope.load_extension('ui-select')

    map('n', 'j', tb.find_files, 'files')
    map('n', '<leader>jg', tb.git_files, 'files')
    map('n', '<leader>jo', tb.oldfiles, 'recent')
    map('n', '<leader>jb', tb.buffers, 'buffers')
    map('n', '<leader>jh', tb.help_tags, 'help')
    map('n', '<leader>jp', tb.live_grep, 'ripgrep project')
    map('n', '<leader>jm', tb.marks, 'marks')
    map('n', '<leader>jq', tb.quickfix, 'quickfix')
    map('n', '<leader>jn', function()
      tb.find_files({ cwd = '~/.config/nvim' })
    end, 'neovim config')
    map('n', '<leader>js', tb.lsp_dynamic_workspace_symbols, 'find project symbol')
    map('n', 'gr', tb.lsp_references, 'goto reference')
    map('n', 'gd', tb.lsp_definitions, 'goto definition')
    map('n', 'gt', tb.lsp_type_definitions, 'goto type definition')
    map('n', 'gi', tb.lsp_implementations, 'goto implementation')
  end
}
