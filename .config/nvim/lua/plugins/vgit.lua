return {
  'tanvirtin/vgit.nvim',
  enabled = false, -- Seems to error at the moment, maybe due to nightly? Try again later.
  event = 'VimEnter',
  opts = {
    live_blame = {
      enabled = false, -- Seems cool for shared codebases, add toggle keybind
    },
  },
}
