return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  config = function()
    local project = require 'project_nvim'
    project.setup({})
  end
}
