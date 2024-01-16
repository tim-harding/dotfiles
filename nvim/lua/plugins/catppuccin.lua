return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme('catppuccin')
  end,
  opts = {
    -- transparent_background = true,
    flavour = 'frappe',
    no_underline = true,
    term_colors = true,
    styles = {
      comments = { 'italic' },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    custom_highlights = function(colors)
      return {
        -- Use :Inspect to see highlights under the cursor
        ['@namespace'] = { style = {} },
      }
    end,
    integrations = {
      which_key = true,
      leap = true,
      noice = true,
      lsp_trouble = true,
    },
  }
}
