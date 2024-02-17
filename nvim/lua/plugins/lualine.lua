return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'linrongbin16/lsp-progress.nvim' },
  lazy = false,
  config = function()
    local lualine = require('lualine')
    local noice_api = require('noice.api')
    local lsp_progress = require('lsp-progress')

    lsp_progress.setup({})

    local group = vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'LspProgressStatusUpdated',
      callback = lualine.refresh,
    })

    local macro_string = ''

    vim.api.nvim_create_autocmd('RecordingEnter', {
      group = group,
      pattern = '*',
      callback = function()
        local reg = vim.fn.reg_recording()
        macro_string = string.format('Recording @%s', reg)
        lualine.refresh({
          trigger = 'autocmd',
        })
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      group = group,
      pattern = '*',
      callback = function()
        macro_string = ''
        lualine.refresh({
          trigger = 'autocmd',
        })
      end,
    })

    local RELATIVE = 1

    lualine.setup({
      options = {
        theme = 'catppuccin',
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },

      sections = {
        lualine_a = { 'branch' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            path = RELATIVE,
          },
          lsp_progress.progress,
        },
        lualine_x = { function() return macro_string end },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
    })
  end
}
