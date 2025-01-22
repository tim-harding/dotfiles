return {
  'subnut/nvim-ghost.nvim',
  event = 'VeryLazy',
  init = function()
    -- :GhostTextStart to start manually
    vim.g.nvim_ghost_autostart = 0
  end
}
