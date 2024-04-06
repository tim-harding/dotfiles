return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  opts = {
    view = {
      default = {
        layout = 'diff2_vertical',
      },
    },
    file_panel = {
      win_config = {
        position = 'bottom',
        height = 10,
      }
    },
  },
}
