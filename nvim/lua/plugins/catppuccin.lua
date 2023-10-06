return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  priority = 1000,
  opts = {
    -- latte, frappe, macchiato, mocha
    flavour = 'frappe',
    no_underline = true,
    term_colors = true,
    integrations = {
      which_key = true,
      leap = true,
    },
  }
}
