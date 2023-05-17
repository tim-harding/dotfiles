local extension_path = "/usr/lib/codelldb/lldb/"
local codelldb_path = extension_path .. "bin/codelldb"
local liblldb_path = extension_path .. "lib/liblldb.so"

return {
  {
    "simrat39/rust-tools.nvim",
    opts = function()
      return {
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>h", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
          end,
        },
        hover_actions = {
          auto_focus = true,
        },
      }
    end,
  },
}
