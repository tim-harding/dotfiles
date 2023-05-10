-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "<c-tab>", ":bn<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-tab>", "<esc>:bn<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-s-tab>", ":bp<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-s-tab>", "<esc>:bp<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-w>", ":bd<cr>", { noremap = true, silent = true })
