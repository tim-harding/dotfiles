local map = require('shared').map

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  event = 'VeryLazy',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
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
            ['<esc>'] = actions.close,
          },
        },
      },
    }
    telescope.load_extension('fzf')

    map('n', 'jj', tb.oldfiles, 'recent')
    map('n', 'jg', tb.git_files, 'git')
    map('n', 'jf', tb.find_files, 'files')
    map('n', 'jh', tb.help_tags, 'help')
    map('n', 'jp', tb.live_grep, 'search project')
    map('n', 'jb', tb.current_buffer_fuzzy_find, 'search buffer')
    map('n', 'jc', tb.commands, 'commands')
    map('n', 'jr', tb.registers, 'paste register')
    map('n', 'jm', tb.marks, 'marks')
    map('n', 'jq', tb.quickfix, 'quickfix')
    map('n', 'jn', function() tb.find_files({ cwd = '~/.config/nvim' }) end, 'neovim config')
    map('n', 'jt', ":TodoTelescope<cr>", 'todos')

    map('n', 'ls', tb.lsp_document_symbols, 'find document symbol')
    map('n', 'lS', tb.lsp_workspace_symbols, 'find workspace symbol')
    map('n', 'li', tb.lsp_implementations, 'find implementation')
    map('n', 'lr', tb.lsp_references, 'find reference')

    map('n', 'hhc', tb.git_commits, 'search commits')
    map('n', 'hhb', tb.git_branches, 'search branches')
    map('n', 'hhs', tb.git_status, 'search status')
  end,
}
