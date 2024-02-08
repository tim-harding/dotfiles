return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'linrongbin16/lsp-progress.nvim' },
  lazy = false,
  config = function()
    local lualine = require('lualine')
    local noice_api = require('noice.api')
    local lsp_progress = require('lsp-progress')

    lsp_progress.setup({})

    local group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "LspProgressStatusUpdated",
      callback = lualine.refresh,
    })

    local function macro_record_state()
      if noice_api.statusline.mode.has() then
        return noice_api.statusline.mode.get()
      else
        return ""
      end
    end

    local RELATIVE = 1

    lualine.setup({
      options = {
        theme = 'catppuccin',
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },

      sections = {
        lualine_a = { { 'filename', path = RELATIVE } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { lsp_progress.progress },
        lualine_x = { macro_record_state },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
    })
  end
}
