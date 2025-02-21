return {
  "nvim-treesitter/nvim-treesitter-context",
  event = 'VeryLazy',

  config = function()
    local ts = require("treesitter-context")
    ts.disable()
    vim.keymap.set("n", "[x", function()
      ts.go_to_context(vim.v.count1)
    end, { silent = true })
    vim.keymap.set("n", "<leader>x", function()
      ts.toggle()
    end, { silent = true })
  end
}
