local keymap = vim.keymap

-- leader key
vim.g.mapleader = " " -- set the leader key

keymap.set("n", "<leader>r", ":source %<CR>", { desc = "Source the current lua file" }) -- reload the current lua page

keymap.set("n", "<leader>-", ":nohl<CR>", { desc = "Clear search highlights" }) -- clear search highlights
keymap.set("n", "<leader>p", ":e #<CR>", { desc = "Jump to the previous buffer" }) -- jump to the previous buffer
keymap.set("n", "<leader> ", "<cmd>w<CR>", { desc = "Write the current buffer" }) -- goto previous tab

-- split management
keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically" }) -- split vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" }) -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make splits equal width/height
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" }) -- close the current slit
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close the current slit
