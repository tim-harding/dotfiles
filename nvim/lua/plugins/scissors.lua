local config_dir = vim.fn.stdpath('config')
local snippet_dir = config_dir .. '/scissor-snippets/'

return {
  'chrisgrieser/nvim-scissors',
  opts = {
    snippetDir = snippet_dir,
    jsonFormatter = 'jq',
    editSnippetPopup = {
      keymaps = {
        saveChanges = '<leader>s'
      }
    }
  },
  keys = {
    {
      '<leader>ke', -- sKissors :)
      function() require('scissors').editSnippet() end,
    },
    {
      '<leader>ka',
      function() require('scissors').addNewSnippet() end,
      mode = { 'x', 'n' },
    }
  }
}
