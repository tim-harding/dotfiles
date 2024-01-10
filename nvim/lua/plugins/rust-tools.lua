local shared = require('shared')

return {
  'simrat39/rust-tools.nvim',
  ft = { 'rust' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local extensions_dir = vim.env.HOME .. '/.vscode/extensions'
    local this_os = vim.loop.os_uname().sysname

    local scan = require('plenary.scandir')
    local rt = require('rust-tools')

    local dirs = scan.scan_dir(extensions_dir, {
      depth = 1,
      only_dirs = true,
    })

    local vscode_pattern = 'vadimcn%.vscode%-lldb%-%d%.%d%.%d'
    local vscode_dir = ''
    for _, entry in ipairs(dirs) do
      local is_vscode_lldb = string.find(entry, vscode_pattern) ~= nil
      if is_vscode_lldb then
        vscode_dir = entry
        break
      end
    end

    if vscode_dir == '' then
      error('Could not find vscode-lldb extension')
    end

    local codelldb_path = vscode_dir .. '/adapter/codelldb'
    local liblldb_path = vscode_dir .. '/lldb/lib/liblldb'

    if this_os:find 'Windows' then
      codelldb_path = extension_path .. 'adapter/codelldb.exe'
      liblldb_path = extension_path .. 'lldb/bin/liblldb.dll'
    else
      liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
    end

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
