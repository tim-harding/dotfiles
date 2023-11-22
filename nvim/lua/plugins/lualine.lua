return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = false,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          path = 1, -- Relative path
        },
      },
      lualine_x = {
        function()
          local noice = require('noice.api')
          if noice.statusline.mode.has() then
            return noice.statusline.mode.get()
          else
            return ""
          end
        end
      },
      lualine_y = { 'filetype' },
      lualine_z = { 'location' },
    },
  }
}
