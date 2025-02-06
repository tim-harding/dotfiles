return {
  "nvim-treesitter/nvim-treesitter-context",
  event = 'VeryLazy',

  config = function()
    local ts = require("treesitter-context")
    vim.keymap.set("n", "[x", function() ts.go_to_context(vim.v.count1) end, { silent = true })
  end
}
