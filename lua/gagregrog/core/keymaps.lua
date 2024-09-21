local keymap = vim.keymap

-- leader key
vim.g.mapleader = " " -- set the leader key

keymap.set("n", "<leader>r", ":source %<CR>", { desc = "Source the current file" })

keymap.set("n", "<leader>-", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>p", ":e #<CR>", { desc = "Jump to the previous buffer" })
keymap.set("n", "<leader> ", "<cmd>w<CR>", { desc = "Write the current buffer" })
keymap.set("n", "<leader>W", "<cmd>noa w<CR>", { desc = "Write the current buffer without formatting" })
keymap.set("n", "QQ", ":q<CR>", { desc = "Close the current buffer" })
keymap.set("n", "yp", "yyp", { desc = "Duplicate line" })

-- split management
keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
