return {
  'mrcjkb/rustaceanvim',
  lazy = false,
  version = '^4',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local shared = require('shared')

    local function dap_adapter()
      local cfg = require('rustaceanvim.config')
      if shared.is_linux() then
        local codelldb_dir = '/usr/lib/codelldb/adapter/'
        local codelldb_path = codelldb_dir .. 'codelldb'
        local liblldb_path = codelldb_dir .. 'libcodelldb.so'
        return cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      elseif shared.is_darwin() then
        local codelldb_dir = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
        local codelldb_path = codelldb_dir .. 'adapter/codelldb'
        local liblldb_path = codelldb_dir .. 'lldb/lib/liblldb.dylib'
        return cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      end
    end

    local augroup = vim.api.nvim_create_augroup('RustLspAttach', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      pattern = { '*.rs' },
      callback = function(event)
        vim.bo[event.buf].textwidth = 80
      end
    })

    vim.g.rustaceanvim = function()
      return {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        dap = {
          adapter = dap_adapter(),
          autoload_configurations = true,
        },
      }
    end
  end
}
