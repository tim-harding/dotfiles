return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = false,
      component_separators = '|',
      section_separators = ''
    },
    sections = {
      lualine_c = {
        function()
          local navic = require('nvim-navic')
          if navic.is_available() then
            return navic.get_location()
          else
            return ""
          end
        end
      },
      lualine_x = {},
      lualine_y = { 'filetype' },
      lualine_z = { 'filename' }
    }
  }
}
