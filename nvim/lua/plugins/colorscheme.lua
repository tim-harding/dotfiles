return {
  -- add gruvbox
  { "catppuccin/nvim" },

  { "shaunsingh/nord.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-macchiato",
      colorscheme = "nord",
    },
  },
}
