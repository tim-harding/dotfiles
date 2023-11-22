local map = require('shared').map

return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = "*",
  dependencies = 'catppuccin',
  config = function()
    local bufferline = require('bufferline')
    local groups = require('bufferline.groups')
    local commands = require('bufferline.commands')
    local state = require('bufferline.state')
    bufferline.setup({
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        groups = {
          items = {
            groups.builtin.pinned:with({ icon = "" })
          }
        }
      },
    })

    map('n', '<s-left>', function() bufferline.cycle(-1) end, 'previous buffer')
    map('n', '<s-right>', function() bufferline.cycle(1) end, 'next buffer')
    map('n', '<s-up>', function() bufferline.move(-1) end, 'move buffer left')
    map('n', '<s-down>', function() bufferline.move(1) end, 'move buffer right')
    map('n', '<c-c>', function()
      local index = commands.get_current_element_index(state)
      bufferline.unpin_and_close()
      if index ~= nil then
        commands.go_to(index + 1)
      end
    end, 'close buffer')
    map('n', '<c-p>', groups.toggle_pin, 'toggle pin')
    map('n', '<leader>c', function()
      -- Excludes special buffers not shown by Bufferline, such as Trouble
      local elements = bufferline.get_elements().elements
      groups.action(groups.builtin.ungrouped.name, function(buf)
        for _, e in ipairs(elements) do
          if e.id == buf.id then
            vim.schedule(function()
              vim.cmd.bdelete(buf.id)
            end)
          end
        end
      end)
    end, 'close others')
  end
}
