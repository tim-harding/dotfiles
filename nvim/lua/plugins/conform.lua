return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo' },
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,
  config = function()
    local conform = require('conform')

    local is_format_enabled = true
    vim.api.nvim_create_user_command('AutoformatToggle', function()
      is_format_enabled = not is_format_enabled
      if is_format_enabled then
        vim.notify('Autoformat enabled')
      else
        vim.notify('Autoformat disabled')
      end
    end, {})

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        liquid = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
        html = { 'prettierd' },
        scss = { 'prettierd' },
        markdown = { 'prettierd' },
        yaml = { 'prettierd' },

        haskell = { 'fourmolu' },
        ocaml = { 'ocamlformat' },
        python = { 'black' },
        swift = { 'swiftformat' },
      },
      format_on_save = function()
        if is_format_enabled then
          return { lsp_fallback = true }
        end
      end
    })
  end,
}
