return {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
  enabled = false, -- Can't get files or git_files picker to work. Try again later.
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup({
      'default',
      'fzf-native',
      'hide',
    })

    fzf.register_ui_select()

    local map = require 'shared'.map
    map('n', '<leader>jj', fzf.resume, 'resume')
    map('n', '<leader>jf', fzf.files, 'files')
    map('n', '<leader>jg', fzf.git_files, 'git files')
    map('n', '<leader>jh', fzf.helptags, 'help')
    map('n', '<leader>jr', fzf.live_grep_native, 'ripgrep project')
    map('n', '<leader>jq', fzf.quickfix, 'quickfix')
    map('n', '<leader>js', fzf.lsp_workspace_symbols, 'find project symbol')
    map('n', '<leader>jd', function()
      fzf.files({ cwd = '~/dotfiles' })
    end, 'Dotfiles')
  end
}
