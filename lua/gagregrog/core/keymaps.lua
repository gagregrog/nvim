local keymap = vim.keymap


-- leader key
vim.g.mapleader = " "                                                                             -- set the leader key

keymap.set("i", "<leader>-", "<ESC>", { desc = "Exit insert mode" })                              -- exit insert mode

keymap.set("n", "<leader>r", ":source %<CR>", { desc = "Source the current lua file" })           -- reload the current lua page

keymap.set("n", "<leader>-", ":nohl<CR>", { desc = "Clear search highlights" })                   -- clear search highlights


-- split management
keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically" })                     -- split vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" })                   -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                      -- make splits equal width/height
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })                 -- close the current slit


-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                       -- open new tab
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })                -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                       -- goto next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                   -- goto previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })   -- goto previous tab
