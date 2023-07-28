local shared = require('shared')

return {
  'simrat39/rust-tools.nvim',
  ft = { 'rust' },
  opts = {
    server = {
      cmd = { 'ra-multiplex' },
      standalone = false,
      on_attach = function(_, bufnr)
        local rt = require('rust-tools')
        shared.on_attach(_, bufnr)
        shared.map('n', 'lh', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
      end,
    },
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    }
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rust_tools_lldb-vscode",
      },
    },
  }
}
