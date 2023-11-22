return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  priority = 1000,
  opts = {
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
    custom_highlights = function(_)
      return {
        -- Use :Inspect to see highlights under the cursor
        ['@namespace'] = { style = {} },
      }
    end,
    integrations = {
      which_key = true,
      leap = true,
    },
  }
}
