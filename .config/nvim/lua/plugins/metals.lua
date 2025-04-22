return {
  "nvim-lua/plenary.nvim",
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals = require 'metals'
      local metals_config = metals.bare_config()

      -- Enables 'Select Test Suite' and 'Select Test Case' commands,
      -- but disables test class code lenses.
      --[[
      metals_config.settings = {
        testUserInterface = "Test Explorer",
      }
      --]]

      metals_config.on_attach = function()
        metals.setup_dap()
      end
      return metals_config
    end,
    config = function(self, metals_config)
      local metals = require 'metals'
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
      vim.keymap.set('n', '<leader>jm', function()
        require('telescope').extensions.metals.commands()
      end, { desc = 'Metals commands' })
    end
  }
}
