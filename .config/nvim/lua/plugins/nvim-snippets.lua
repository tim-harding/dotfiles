return {
  'garymjr/nvim-snippets',
  enabled = false,
  event = 'VeryLazy',
  init = function()
    vim.api.nvim_set_hl(0, 'SnippetTabstop', {})
  end,
  opts = {
    search_paths = { require('shared').snippet_path },
  },
}
