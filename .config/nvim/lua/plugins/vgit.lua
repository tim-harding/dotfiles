return {
  'tanvirtin/vgit.nvim',
  event = 'VimEnter',
  config = function() require("vgit").setup() end,
}
