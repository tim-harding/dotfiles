return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require('which-key')

    wk.setup({
      triggers_blacklist = {
        n = {},
        i = {},
        v = {},
      }
    })

    local leaders = {
      g = 'Git',
      d = 'Dap',
      j = 'Jump (Telescope)',
      k = 'Scissors',
      l = 'Leetcode',
    }

    local leaders_mapped = {}
    for key, value in pairs(leaders) do
      local map = string.format('<leader>%s', key)
      leaders_mapped[map] = {
        name = value,
        _ = 'which_key_ignore',
      }
    end

    wk.register(leaders_mapped)
  end
}
