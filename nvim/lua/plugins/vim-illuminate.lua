return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  enabled = false,
  config = function()
    require('illuminate').configure({
      large_file_cutoff = 10000,
      providers = {
        'lsp',
        'treesitter',
      }
    })
  end
}
