local map = require('shared').map

return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = "*",
  dependencies = 'catppuccin',
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    })

    map('n', '<s-left>', function() bufferline.cycle(-1) end, 'previous buffer')
    map('n', '<s-right>', function() bufferline.cycle(1) end, 'next buffer')
    map('n', '<s-up>', function() bufferline.move(-1) end, 'move buffer left')
    map('n', '<s-down>', function() bufferline.move(1) end, 'move buffer right')
  end
}
