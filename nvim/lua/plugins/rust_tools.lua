local shared = require('shared')

return {
  'simrat39/rust-tools.nvim',
  opts = {
    server = {
      on_attach = function(_, bufnr)
        local rt = require('rust-tools')
        shared.on_attach(_, bufnr)
        shared.map('n', 'lh', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
      end,
    },
    hover_actions = {
      auto_focus = true,
    }
  }
}
