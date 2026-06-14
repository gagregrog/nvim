-- Shared git-common-dir gating for machine-private nvim files.
--
-- Both the post-setup module loader (private.lua) and the pre-setup spec
-- splice (lazy.lua) read a ';'-separated env var of "<git-common-dir>|<lua-file>"
-- entries and act only on files whose git-common-dir matches nvim's current
-- repo. --git-common-dir (rather than --show-toplevel) means all worktrees of
-- the same repo share a key.

local M = {}

local function normalize(p)
	return (vim.fn.fnamemodify(vim.fn.expand(p), ":p"):gsub("/$", ""))
end

local function current_git_common_dir()
	local out = vim.fn.system({ "git", "rev-parse", "--git-common-dir" })
	if vim.v.shell_error ~= 0 then return nil end
	local trimmed = vim.trim(out)
	if trimmed == "" then return nil end
	return normalize(trimmed)
end

-- Returns the readable lua file paths registered under `env_var` whose
-- git-common-dir matches the current repo. Empty when the var is unset, nvim
-- is outside a git repo, or nothing matches.
function M.matching_files(env_var)
	local raw = os.getenv(env_var)
	if not raw or raw == "" then return {} end

	local current = current_git_common_dir()
	if not current then return {} end

	local files = {}
	for entry in string.gmatch(raw, "[^;]+") do
		local git_dir, lua_path = entry:match("^([^|]+)|(.+)$")
		if git_dir and lua_path and normalize(git_dir) == current then
			local expanded = vim.fn.expand(lua_path)
			if vim.fn.filereadable(expanded) == 1 then
				table.insert(files, expanded)
			end
		end
	end
	return files
end

return M
