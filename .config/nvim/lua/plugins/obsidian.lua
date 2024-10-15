-- Note:
-- Default telescope mappings are
-- - <C-x>: new note from query
-- - <C-l>: Insert a link to selected note

return {
  "nvim-lua/plenary.nvim",
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = 'VeryLazy',
    init = function()
      vim.g.vim_markdown_frontmatter = 1
    end,
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand('$HOME') .. "/Documents/obsidian",
        },
      },
      notes_subdir = 'notes',
      daily_notes = {
        folder = 'dailies',
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      new_notes_location = "current_dir",
      wiki_link_func = 'prepend_note_id',
      markdown_link_func = 'prepend_note_id',
    },
  }
}
