return {
  'chrisgrieser/nvim-scissors',
  event = 'VeryLazy',
  config = function()
    local shared = require 'shared'
    local scissors = require 'scissors'

    scissors.setup {
      snippetDir = shared.snippet_path,
      jsonFormatter = 'jq',
      editSnippetPopup = {
        keymaps = {
          saveChanges = '<leader>s'
        }
      }
    }

    shared.map(
      'n',
      '<leader>ke', -- sKissors :)
      scissors.editSnippet,
      'edit snippet'
    )
    shared.map(
      { 'x', 'n' },
      '<leader>ka',
      scissors.addNewSnippet,
      'edit snippet'
    )
  end,
}

-- Keymap defaults:      |
---------------------------------
-- cancel                | q
-- goBackToSearch        | <BS>
-- deleteSnippet         | <C-BS>
-- duplicateSnippet      | <C-d>
-- openInFile            | <C-o>
-- insertNextPlaceholder | <C-p>
