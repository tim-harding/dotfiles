return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  config = function()
    local flash = require('flash')
    local map = require('shared').map

    local labels_str = 'setnrigmfuplwycdhxaoq'

    flash.setup({
      labels = labels_str,
      modes = {
        search = {
          labels = labels_str:upper(),
        },
        char = {
          enabled = false,
        },
        treesitter = {
          labels = "STRGPWBAVDXFC",
        }
      },
    })

    map({ 'n', 'x', 'o' }, '<M-s>', flash.treesitter, 'flash treesitter')
  end,
}
