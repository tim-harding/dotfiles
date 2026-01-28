return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  cmd = { 'ConformInfo' },
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,

  opts = function()
    local is_format_enabled_global = vim.env.AUTOFORMAT_DEFAULT == "1"
    local function format(opts)
      local is_global
      local mode = 'toggle'
      for _, arg in ipairs(opts.fargs) do
        if arg == 'on' or arg == 'off' or arg == 'toggle' then
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

      if mode == 'on' then
        is_format_enabled = true
      elseif mode == 'off' then
        is_format_enabled = false
      elseif mode == 'toggle' then
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
    end


    vim.api.nvim_create_user_command('Autoformat', format, {
      nargs = '*',
      complete = function(_, _, _)
        return { 'on', 'off', 'toggle', 'local', 'global' }
      end
    })

    ---@type conform.setupOpts
    return {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        liquid = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        svelte = { 'prettierd', 'prettier', stop_after_first = true },

        rust = { 'rustfmt' },
        zig = { 'zigfmt' },
        fish = { 'fish_indent' },
        nix = { 'nixfmt' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        haskell = { 'fourmolu' },
        ocaml = { 'ocamlformat' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        swift = { 'swiftformat' },
        -- yaml = { 'yamlfmt' },
        scala = { 'scalafmt' },
        go = { 'gofmt' },
      },

      formatters = {
        sqlfluff = {
          command = 'sqlfluff',
          args = { 'fix', '-' },
          cwd = require('conform.util').root_file('.sqlfluff'),
        },
      },

      default_format_opts = {
        lsp_format = "fallback",
      },

      format_after_save = function()
        local is_format_enabled = is_format_enabled_global
        if vim.b.is_format_enabled ~= nil then
          is_format_enabled = vim.b.is_format_enabled
        end

        if is_format_enabled then return {} end
      end,
    }
  end,
}
