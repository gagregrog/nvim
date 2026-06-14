-- Post-setup private module loader.
--
-- dofile()s each file registered in NVIM_PRIVATE_MODULES, gated by
-- git-common-dir (see private_util.lua). Runs after lazy.setup, so these
-- modules can set globals/keymaps/etc. but cannot register plugin specs —
-- those go through NVIM_PRIVATE_SPECS in lazy.lua instead.

for _, file in ipairs(require("gagregrog.private_util").matching_files("NVIM_PRIVATE_MODULES")) do
	local ok, err = pcall(dofile, file)
	if not ok then
		vim.notify(
			"Private module failed to load (" .. file .. "): " .. tostring(err),
			vim.log.levels.WARN
		)
	end
end
