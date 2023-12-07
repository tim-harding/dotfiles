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
      tools = {
        inlay_hints = {
          auto = false,
          other_hints_prefix = '-> ',
        },
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        -- cmd = { 'ra-multiplex' },
        standalone = false,
        on_attach = function(_, bufnr)
          shared.on_attach(_, bufnr)
          shared.map('n', 'gH', rt.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
          vim.opt.textwidth = 80
        end,
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })

    local inlay_hints_enabled = false
    shared.map('n', '<leader>i', function()
      inlay_hints_enabled = not inlay_hints_enabled
      if inlay_hints_enabled then
        rt.inlay_hints.enable()
      else
        rt.inlay_hints.disable()
      end
    end)
  end,
}
