return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
      disabled_filetypes = {
        statusline = { 'oil' },
      }
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
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },

    winbar = {
      lualine_c = {
        function()
          local navic = require('nvim-navic')
          if navic.is_available() then
            return navic.get_location()
          else
            return [[]]
          end
        end
      },
      lualine_z = {
        {
          'tabs',
          mode = 2, -- Tab number and tab name
        },
      },
    }
  }
}
