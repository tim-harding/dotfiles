local map = require('shared').map

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x', -- Release branch
  event = 'VeryLazy',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local tb = require('telescope.builtin')

    telescope.setup {
      defaults = {
        layout_strategy = 'vertical',
        theme = 'dropdown',
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<esc>'] = actions.close,
            ['<C-h>'] = 'which_key',
          }
        }
      }
    }
    telescope.load_extension('fzf')

    map('n', 'j', tb.find_files, 'files')
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
    map('n', 'gi', tb.lsp_implementations, 'goto implementation')
  end
}
