return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, { noremap = true, silent = true } }
    end,
  },
}
