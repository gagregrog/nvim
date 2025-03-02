local keymap = require("gagregrog.core.keymap")

-- leader key
vim.g.mapleader = " " -- set the leader key
vim.g.maplocalleader = "," -- set the local leader key

keymap.nmap("<leader>ch", ":nohl<CR>", "Clear search highlights")
keymap.nmap("<leader>p", ":e #<CR>", "Jump to the previous buffer")
keymap.nmap("<leader> ", "<cmd>w<CR>", "Write the current buffer")
keymap.nmap("<leader>W", "<cmd>noa w<CR>", "Write the current buffer without formatting")
keymap.nmap("QQ", ":q<CR>", "Close the current buffer")
keymap.nmap("yp", "yyp", "Duplicate line")

-- split management
keymap.nmap("<leader>s|", "<C-w>v", "Split window vertically")
keymap.nmap("<leader>s-", "<C-w>s", "Split window horizontally")
keymap.nmap("<leader>se", "<C-w>=", "Make splits equal size")
keymap.nmap("<leader>sc", "<cmd>close<CR>", "Close current split")
keymap.nmap("<leader>sx", "<cmd>close<CR>", "Close current split")

-- increment/decrement
keymap.nmap("<A-a>", "<C-a>", "Increment number under cursor")
keymap.nmap("<A-r>", "<C-x>", "Decrement number under cursor")
