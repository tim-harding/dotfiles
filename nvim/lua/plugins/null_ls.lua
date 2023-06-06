return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    ensure_installed = nil,
    automatic_installation = true,
  },
  dependencies = {
    'williamboman/mason.nvim',
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      }
    },
  },
}
