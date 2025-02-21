return {
  'theHamsta/nvim-dap-virtual-text',
  event = 'VeryLazy',
  enabled = false,
  opts = {
    highlight_new_as_changed = true,
    display_callback = function(variable, buf)
      local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
      if ft == 'javascript' or ft == 'typescript' then
        return nil
      else
        return variable.name .. ' = ' .. variable.value
      end
    end
  },
}
