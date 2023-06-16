local util = require('util')

return {
  'simrat39/rust-tools.nvim',
  opts = {
    server = {
      on_attach = function(_, bufnr)
        local rt = require('rust-tools')
        util.on_attach(_, bufnr)
        util.map('n', 'lh', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
      end,
    },
    hover_actions = {
      auto_focus = true,
    }
  }
}
