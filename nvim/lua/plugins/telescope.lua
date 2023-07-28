local map = require('shared').map

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  event = 'VeryLazy',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local tb = require('telescope.builtin')

    telescope.setup {
      defaults = {
        layout_strategy = 'vertical',
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<esc>'] = actions.close
          }
        }
      }
    }
    pcall(telescope.load_extension, 'fzf')

    map('n', 'j', tb.find_files, 'files')
    map('n', '<leader>jo', tb.oldfiles, 'recent')
    map('n', '<leader>jh', tb.help_tags, 'help')
    map('n', '<leader>jrp', tb.live_grep, 'ripgrep project')
    map('n', '<leader>jrb', tb.current_buffer_fuzzy_find, 'ripgrep buffer')
    map('n', '<leader>jc', tb.commands, 'commands')
    map('n', '<leader>jp', tb.registers, 'paste register')
    map('n', '<leader>jm', tb.marks, 'marks')
    map('n', '<leader>jq', tb.quickfix, 'quickfix')
    map('n', '<leader>jn', function() tb.find_files({ cwd = '~/.config/nvim' }) end,
      'neovim config')
    map('n', '<leader>jt', ":TodoTelescope<cr>", 'todos')

    map('n', '<leader>js', tb.lsp_workspace_symbols, 'find project symbol')
    map('n', '<leader>ji', tb.lsp_implementations, 'find implementation')

    -- TODO: If there is only one item, select it
    -- map('n', 'gr', tb.lsp_references, 'find reference')
    -- map('n', 'gd', tb.lsp_definitions, 'find definition')
  end
}
