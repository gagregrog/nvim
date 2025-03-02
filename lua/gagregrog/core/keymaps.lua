local map = require("gagregrog.core.keymap")

-- leader key
vim.g.mapleader = " " -- set the leader key

map.nmap("<leader>ch", ":nohl<CR>", "Clear search highlights")
map.nmap("<leader>p", ":e #<CR>", "Jump to the previous buffer")
map.nmap("<leader> ", "<cmd>w<CR>", "Write the current buffer")
map.nmap("<leader>W", "<cmd>noa w<CR>", "Write the current buffer without formatting")
map.nmap("QQ", ":q<CR>", "Close the current buffer")
map.nmap("yp", "yyp", "Duplicate line")

-- split management
map.nmap("<leader>s|", "<C-w>v", "Split window vertically")
map.nmap("<leader>s-", "<C-w>s", "Split window horizontally")
map.nmap("<leader>se", "<C-w>=", "Make splits equal size")
map.nmap("<leader>sc", "<cmd>close<CR>", "Close current split")
map.nmap("<leader>sx", "<cmd>close<CR>", "Close current split")

-- increment/decrement
map.nmap("<A-a>", "<C-a>", "Increment number under cursor")
map.nmap("<A-r>", "<C-x>", "Decrement number under cursor")
