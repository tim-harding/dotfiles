local shared = require('shared')

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

return {
  'simrat39/rust-tools.nvim',
  ft = { 'rust' },
  config = function()
    local rt = require('rust-tools')
    rt.setup({
      server = {
        -- cmd = { 'ra-multiplex' },
        standalone = false,
        on_attach = function(_, bufnr)
          shared.on_attach(_, bufnr)
          shared.map('n', 'gH', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
          vim.opt.textwidth = 80
        end,
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end,
}
