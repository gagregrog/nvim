local M = {}

-- Helper function to create keymaps with consistent options
function M.set(mode, lhs, rhs, desc, optsOverrides)
	local opts = optsOverrides or {}
	opts.desc = desc
	opts.silent = opts.silent ~= false -- silent true by default unless explicitly set to false
	opts.noremap = opts.noremap ~= false -- noremap true by default unless explicitly set to false

	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Common mapping helpers
function M.nmap(lhs, rhs, desc, opts)
	M.set("n", lhs, rhs, desc, opts)
end

function M.imap(lhs, rhs, desc, opts)
	M.set("i", lhs, rhs, desc, opts)
end

function M.vmap(lhs, rhs, desc, opts)
	M.set("v", lhs, rhs, desc, opts)
end

-- For visual and select mode
function M.xmap(lhs, rhs, desc, opts)
	M.set("x", lhs, rhs, desc, opts)
end

-- For terminal mode
function M.tmap(lhs, rhs, desc, opts)
	M.set("t", lhs, rhs, desc, opts)
end

return M
