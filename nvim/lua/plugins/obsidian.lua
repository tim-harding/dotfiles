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
      vim.opt.conceallevel = 2
    end,
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand('$HOME') .. "/Documents/personal/obsidian",
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

      -- TODO: Consider 'current_dir' instead
      new_notes_location = "notes_subdir",

      -- TODO: Consider
      --  "use_alias_only", e.g. '[[Foo Bar]]'
      --  "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  "use_path_only", e.g. '[[foo-bar.md]]'
      wiki_link_func = 'prepend_note_id',
      markdown_link_func = 'prepend_note_id',
    },
  }
}
