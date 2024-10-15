-- Note:
-- Default telescope mappings are
-- - <C-x>: new note from query
-- - <C-l>: Insert a link to selected note

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('Obsidian', {}),
  pattern = 'markdown',
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

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
          path = "~/Documents/obsidian",
        },
      },

      new_notes_location = "current_dir",
      wiki_link_func = 'prepend_note_id',
      markdown_link_func = 'prepend_note_id',
      notes_subdir = 'notes',
      daily_notes = { folder = 'dailies' },

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
    },

    keys = {
      {
        '<leader>jo',
        '<Cmd>ObsidianQuickSwitch<Cr>',
      },
      {
        '<leader>jO',
        '<Cmd>ObsidianSearch<Cr>',
      },
    },
  },
}
