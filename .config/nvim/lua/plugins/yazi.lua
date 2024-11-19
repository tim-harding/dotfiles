return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>f",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    -- {
    --   -- Open in the current working directory
    --   "<leader><S-f>",
    --   "<cmd>Yazi cwd<cr>",
    --   desc = "Open the file manager in nvim's working directory",
    -- },
    -- {
    --   '<c-up>',
    --   "<cmd>Yazi toggle<cr>",
    --   desc = "Resume the last yazi session",
    -- },
  },
  ---@type YaziConfig
  opts = {
    floating_window_scaling_factor = 1,
    yazi_floating_window_border = 'none',
  },
}
