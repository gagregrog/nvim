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

local specs = {
	{ import = "gagregrog.plugins" },
	{ import = "gagregrog.plugins.lsp" },
}

-- Splice in machine-private plugin specs gated by git-common-dir, so specs
-- that only make sense on a particular machine never load elsewhere. Runs
-- before lazy.setup so `lazy = false` + `build` specs behave exactly like
-- public ones at startup. Each file returns a list of specs; lazy accepts a
-- nested list as a single spec entry. See private_util.lua for the gating.
for _, file in ipairs(require("gagregrog.private_util").matching_files("NVIM_PRIVATE_SPECS")) do
	local ok, result = pcall(dofile, file)
	if ok and type(result) == "table" then
		table.insert(specs, result)
	elseif not ok then
		vim.notify(
			"Private spec failed to load (" .. file .. "): " .. tostring(result),
			vim.log.levels.WARN
		)
	end
end

require("lazy").setup(specs, {
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
