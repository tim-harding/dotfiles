return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  cmd = { 'ConformInfo' },
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,

  opts = function()
    local is_format_enabled_global = true

    vim.api.nvim_create_user_command('Autoformat', function(opts)
      local is_global = true
      local mode = 'toggle'
      for _, arg in ipairs(opts.fargs) do
        if arg == "on" or arg == "off" or arg == "toggle" then
          mode = arg
        elseif arg == 'local' then
          is_global = false
        elseif arg == 'global' then
          is_global = true
        end
      end

      local is_format_enabled
      if is_global then
        is_format_enabled = is_format_enabled_global
      else
        if vim.b.is_format_enabled == nil then
          is_format_enabled = is_format_enabled_global
        else
          is_format_enabled = vim.b.is_format_enabled
        end
      end

      if mode == "on" then
        is_format_enabled = true
      elseif mode == "off" then
        is_format_enabled = false
      elseif mode == "toggle" then
        is_format_enabled = not is_format_enabled
        if is_format_enabled then
          vim.notify('Autoformat enabled')
        else
          vim.notify('Autoformat disabled')
        end
      end

      if is_global then
        is_format_enabled_global = is_format_enabled
      else
        vim.b.is_format_enabled = is_format_enabled
      end
    end, {
      nargs = '*',
      complete = function(_, _, _)
        return { "on", "off", "toggle", 'local', 'global' }
      end
    })

    ---@type conform.setupOpts
    return {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier' },
        javascriptreact = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },
        liquid = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        scss = { 'prettierd', 'prettier' },
        vue = { 'prettierd', 'prettier' },
        svelte = { 'prettierd', 'prettier' },

        rust = { 'rustfmt', lsp_format = 'fallback' },
        lua = { 'lua-format', lsp_format = "prefer" },

        zig = { 'zigfmt', lsp_format = "fallback" },
        fish = { 'fish_indent' },
        nix = { 'nixfmt' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        haskell = { 'fourmolu' },
        ocaml = { 'ocamlformat' },
        python = { 'black' },
        swift = { 'swiftformat' },
        yaml = { 'yamlfmt' },
      },

      formatters = {
        sqlfluff = {
          command = 'sqlfluff',
          args = { 'fix', '-' },
          cwd = require('conform.util').root_file('.sqlfluff')
        }
      },

      format_on_save = function()
        local is_format_enabled = is_format_enabled_global
        if vim.b.is_format_enabled ~= nil then
          is_format_enabled = vim.b.is_format_enabled
        end

        if is_format_enabled then
          return { stop_after_first = true }
        end
      end,
    }
  end,
}
