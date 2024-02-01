return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },

  keys = {
    {
      '<leader>n',
      function()
        vim.cmd('Noice')
      end,
      desc = 'Open Noice',
    },
  },

  opts = {
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
    notify = {
      view = 'mini',
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      message = {
        view = 'mini',
      },
      progress = {
        format_done = {
          { '✓ ', hl_group = 'NoiceLspProgressSpinner' },
          { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
          { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
        },
      },
    },
    messages = {
      view = 'mini',
      view_search = false,
    },
    cmdline = {
      view = 'cmdline',
    },
  },
}
