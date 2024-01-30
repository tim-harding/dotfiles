---@return DapServerConfig | nil
local function dap_adapter()
  local this_os = vim.loop.os_uname().sysname
  if this_os:find('Linux') then
    local codelldb_dir = '/usr/lib/codelldb/adapter/'
    local codelldb_path = codelldb_dir .. 'codelldb'
    local liblldb_path = codelldb_dir .. 'libcodelldb.so'
    local cfg = require('rustaceanvim.config')
    return cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
  end
end

---@type RustaceanOpts
vim.g.rustaceanvim = {
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    -- cmd = { 'ra-multiplex' },
    standalone = false,
    on_attach = function(_, bufnr)
      vim.notify('shared.on_attach')
      shared.on_attach(_, bufnr)
      shared.map(
        'n',
        'gH',
        function() require('rustaceanvim.dap').hover_actions.hover_actions() end,
        'hover action',
        { buffer = bufnr }
      )
      vim.bo.textwidth = 80
    end,
  },
  dap = {
    adapter = dap_adapter,
  },
}

return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  dependencies = { 'nvim-lua/plenary.nvim' },
}
