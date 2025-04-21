return {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup({
      {
        'default',
        'fzf-native',
        'hide',
      },
      winopts = {
        fullscreen = true,
        preview = {
          winopts = {
            number = false,
          },
        },
      },
      grep = {
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --hidden --glob !.git -e',
      },
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
