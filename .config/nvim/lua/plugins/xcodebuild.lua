return {
  'nvim-telescope/telescope.nvim',
  'MunifTanjim/nui.nvim',
  'stevearc/oil.nvim',
  'nvim-treesitter/nvim-treesitter',
  {
    'wojciech-kulik/xcodebuild.nvim',
    event = 'VeryLazy',
    enabled = false,
    config = function()
      require('xcodebuild').setup({
        integrations = {
          xcode_build_server = {
            enabled = true,
          },
        }
      })
    end,
  }
}
