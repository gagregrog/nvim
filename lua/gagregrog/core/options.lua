-- type ":h someOption <enter>" to see details about any of these "vim.opt" settings
local opt = vim.opt

-- file explorer                        (:Explore)
vim.cmd("let g:netrw_liststyle = 3") -- enable tree style file explorer

-- line numbers
opt.relativenumber = true -- relative line numbers above/below the current line
opt.number = true -- current line has the actual line number

-- tabs & indentation
opt.tabstop = 2 -- use 2 spaces in place of a <Tab> character (apparently changing this value to anything other than 8 is a bad idea)
opt.expandtab = true -- convert a tab into the number of spaces dictated by opt.tabstop
opt.shiftwidth = 2 -- use 2 spaces for indentation performed with > and < commands in normal mode
opt.autoindent = true -- copy the indentation from the current line when creating a new line

-- line wrapping
opt.wrap = false -- do not wrap long lines, rather continue to the right

-- search settings
opt.ignorecase = true -- ignore case when searching throughout vim
opt.smartcase = true -- mixed case searches will be case sensitive

-- navigation settings
opt.cursorline = true -- highlight the current cursor line
opt.scrolloff = 999 -- keeps the cursor in the middle of the screen/pane as you move up/down
opt.virtualedit = "block" -- allows selecting past the line end during visual block mode

-- themeing
opt.termguicolors = true -- required for tokyonight theme to work properly
opt.background = "dark" -- color schemes with different modes will be dark
opt.signcolumn = "yes" -- show sign column on the left (prevents text from shifting)

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, eol or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use the system clipboard as the default register

-- splitting windows
opt.splitright = true -- split vertical windows to the right    (:hsplit)
opt.splitbelow = true -- split horizontal windows to the bottom (:split)

-- search/substitution
opt.inccommand = "split" -- shows matching searches in a preview window

-- needed for avante.nvim
-- views can only be fully collapsed with the global statusline
opt.laststatus = 3
