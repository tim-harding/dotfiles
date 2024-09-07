return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  cmd = { 'ConformInfo' },
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,

  opts = function()
    local is_format_enabled = true
    vim.api.nvim_create_user_command('Autoformat', function(opts)
      local arg = opts.fargs[1]
      if arg == "on" then
        is_format_enabled = true
      elseif arg == "off" then
        is_format_enabled = false
      elseif arg == "toggle" then
        is_format_enabled = not is_format_enabled
        if is_format_enabled then
          vim.notify('Autoformat enabled')
        else
          vim.notify('Autoformat disabled')
        end
      end
    end, {
      nargs = 1,
      complete = function(arg_lead, cmd_line, cursor_pos)
        return { "on", "off", "toggle" }
      end
    })

    return {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', },
        javascriptreact = { 'prettierd', 'prettier', },
        typescript = { 'prettierd', 'prettier', },
        typescriptreact = { 'prettierd', 'prettier', },
        liquid = { 'prettierd', 'prettier', },
        css = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier', },
        html = { 'prettierd', 'prettier', },
        scss = { 'prettierd', 'prettier', },
        markdown = { 'prettierd', 'prettier', },
        yaml = { 'prettierd', 'prettier', },
        cpp = { 'clang-format' },
        c = { 'clang-format' },

        haskell = { 'fourmolu' },
        ocaml = { 'ocamlformat' },
        python = { 'black' },
        swift = { 'swiftformat' },
      },
      format_on_save = function()
        if is_format_enabled then
          return {
            lsp_format = "fallback",
            stop_after_first = true,
          }
        end
      end,
    }
  end,
}
