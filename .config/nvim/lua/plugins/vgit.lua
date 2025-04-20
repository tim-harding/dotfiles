return {
  'tanvirtin/vgit.nvim',
  event = 'VimEnter',
  opts = {
    settings = {
      live_blame = {
        enabled = false, -- Seems cool for shared codebases, add toggle keybind
      },
    },
  },
}
