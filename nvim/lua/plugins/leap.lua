return {
  'ggandor/leap.nvim',
  keys = {
    {
      's',
      function()
        require('leap').leap({ target_windows = { vim.fn.win_getid() } })
      end,
      mode = { 'n', 'v' },
    }
  },
}
