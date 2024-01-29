return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  version = '^4',

  config = function()
    local dap = require('rustaceanvim.dap')
    local shared = require('shared')

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
          shared.on_attach(_, bufnr)
          shared.map('n', 'gH', dap.hover_actions.hover_actions, 'hover action', { buffer = bufnr })
          vim.opt.textwidth = 80
        end,
      },
      dap = {},
    }

    local codelldb_dir = '/usr/lib/codelldb/adapter/'
    local codelldb_path = codelldb_dir .. 'codelldb'
    local liblldb_path = codelldb_dir .. 'libcodelldb.so'
    local this_os = vim.loop.os_uname().sysname
    if this_os:find('Linux') then
      local cfg = require('rustaceanvim.config')
      vim.g.rustaceanvim.dap.adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
    end
  end,
}
