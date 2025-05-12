return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require('which-key')
    wk.setup({})

    local leaders = {
      g = 'Git',
      d = 'Dap',
      j = 'Jump (Telescope)',
      k = 'Scissors',
      x = 'Xbase',
      t = 'Neotest',
      n = 'Obsidian',
    }

    local leaders_mapped = {}
    for key, value in pairs(leaders) do
      local map = string.format('<leader>%s', key)
      table.insert(leaders_mapped, {
        map,
        group = value,
      })
    end

    wk.add(leaders_mapped)
  end
}
