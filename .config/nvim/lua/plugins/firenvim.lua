return {
  'glacambre/firenvim',
  lazy = false,
  build = ":call firenvim#install(0)",
  init = function()
    vim.g.firenvim_config = {
      localSettings = {
        ['.*'] = {
          takeover = 'never',
        }
      },
    }

    if vim.g.started_by_firenvim then
      vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        nested = true,
        command = 'write',
      })
    end
  end
}
