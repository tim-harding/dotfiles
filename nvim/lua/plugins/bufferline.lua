local map = require('shared').map

return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = "*",
  dependencies = 'catppuccin',
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    })

    map('n', '<s-up>', function() bufferline.move(-1) end, 'move buffer left')
    map('n', '<s-down>', function() bufferline.move(1) end, 'move buffer right')
  end
}
