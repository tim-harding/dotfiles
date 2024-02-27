return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  enabled = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
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

    local augroup = vim.api.nvim_create_augroup('RustLspAttach', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      pattern = { '*.rs' },
      callback = function(event)
        vim.bo[event.buf].textwidth = 80
      end
    })

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
      },
      dap = {
        -- Not working with latest codelldb update
        -- adapter = dap_adapter,
      },
    }
  end
}
