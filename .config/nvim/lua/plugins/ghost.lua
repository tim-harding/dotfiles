return {
  'subnut/nvim-ghost.nvim',
  event = 'VeryLazy',
  enabled = false, -- Messes up fzf-lua
  init = function()
    -- :GhostTextStart to start manually
    vim.g.nvim_ghost_autostart = 0
  end
}
