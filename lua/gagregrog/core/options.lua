-- type ":h someOption <enter>" to see details about any of these "vim.opt" settings
local opt = vim.opt


-- file explorer                        (:Explore)
vim.cmd("let g:netrw_liststyle = 3")    -- enable tree style file explorer


-- line numbers
opt.relativenumber = true               -- relative line numbers above/below the current line 
opt.number = true                       -- current line has the actual line number


-- tabs & indentation
opt.tabstop = 2                         -- use 2 spaces in place of a <Tab> character (apparently changing this value to anything other than 8 is a bad idea)
opt.expandtab = true                    -- convert a tab into the number of spaces dictated by opt.tabstop
opt.shiftwidth = 2                      -- use 2 spaces for indentation performed with > and < commands in normal mode
opt.autoindent = true                   -- copy the indentation from the current line when creating a new line


-- line wrapping
opt.wrap = true                        -- do not wrap long lines, rather continue to the right


-- search settings
opt.ignorecase = true                   -- ignore case when searching
opt.smartcase = true                    -- mixed case searches will be case sensitive 


-- cursor line
opt.cursorline = true                   -- highlight the current cursor line

-- themeing
opt.termguicolors = true                -- required for tokyonight theme to work properly 
opt.background = "dark"                 -- color schemes with different modes will be dark
opt.signcolumn = "yes"                  -- show sign column on the left (prevents text from shifting)


-- backspace
opt.backspace = "indent,eol,start"      -- allow backspace on indent, eol or insert mode start position


-- clipboard
opt.clipboard:append("unnamedplus")     -- use the system clipboard as the default register

-- splitting windows
opt.splitright = true                    -- split vertical windows to the right    (:hsplit)
opt.splitbelow = true                    -- split horizontal windows to the bottom (:split)
