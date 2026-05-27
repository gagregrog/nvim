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

-- tab management
keymap.nmap("<leader>tt", "<cmd>tabnew<CR>", "New tab")
keymap.nmap("<leader>tT", "<cmd>tabnew %<CR>", "New tab with current file")
keymap.nmap("<leader>tx", "<cmd>tabclose<CR>", "Close current tab")
keymap.nmap("<leader>tX", "<cmd>tabonly<CR>", "Close all other tabs")
keymap.nmap("<leader>tn", "<cmd>tabnext<CR>", "Next tab")
keymap.nmap("<leader>tp", "<cmd>tabprevious<CR>", "Previous tab")
keymap.nmap("<leader>tN", "<cmd>tablast<CR>", "Go to last tab")
keymap.nmap("<leader>tP", "<cmd>tabfirst<CR>", "Go to first tab")
keymap.nmap("<leader>th", "<cmd>-tabmove<CR>", "Move tab left")
keymap.nmap("<leader>tl", "<cmd>+tabmove<CR>", "Move tab right")

-- increment/decrement
keymap.nmap("<A-a>", "<C-a>", "Increment number under cursor")
keymap.nmap("<A-r>", "<C-x>", "Decrement number under cursor")
