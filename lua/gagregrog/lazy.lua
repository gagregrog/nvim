local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "gagregrog.plugins" },
	{ import = "gagregrog.plugins.lsp" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false, -- do not show the alert indicating that the change was detected when saved
	},
	-- Search path for plugins that opt into local dev with `dev = true`
	-- Inert until a spec opts in; lazy then
	-- loads <path>/<plugin-name> instead of cloning from GitHub.
	dev = { path = vim.fn.expand("~/dev") },
})
