return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  enabled = false,
  config = function()
    local ibl = require('ibl')
    local hooks = require('ibl.hooks')
    local colors = require('catppuccin.palettes.frappe')
    local fg = colors.surface0

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = fg })
      vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = fg })
      vim.api.nvim_set_hl(0, 'IblScope', { fg = fg })
    end)

    ibl.setup({
      indent = {
        char = '▎'
      }
    })
  end
}
