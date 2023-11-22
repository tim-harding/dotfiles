return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      message = {
        view = 'mini',
      },
      progress = {
        format_done = {
          { "✓ ", hl_group = "NoiceLspProgressSpinner" },
          { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
          { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
        }
      }
    },
    messages = {
      view = 'mini',
      view_search = false,
    },
    cmdline = {
      view = 'cmdline',
    }
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  }
}
