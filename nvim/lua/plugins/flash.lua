return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  config = function()
    local flash = require('flash')
    local map = require('shared').map

    local labels_str = 'setnrigmfuplwycdhxaoq'

    flash.setup({
      labels = labels_str:upper(),
      search = {
        multi_window = false,
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
        treesitter = {
          -- labels = "STRGPWBAVDXFC",
        }
      },
    })

    map({ 'n', 'x', 'o' }, '<M-s>', flash.treesitter, 'flash treesitter')
  end,
}
