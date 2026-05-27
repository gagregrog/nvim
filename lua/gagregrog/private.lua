-- Private nvim module loader.
--
-- Reads NVIM_PRIVATE_MODULES, a ';'-separated list of "<git-common-dir>|<lua-file>"
-- entries. Each module is loaded only when nvim's cwd is inside a git repo
-- whose common dir matches. --git-common-dir (rather than --show-toplevel)
-- means all worktrees of the same repo share a key.

local raw = os.getenv("NVIM_PRIVATE_MODULES")
if not raw or raw == "" then return end

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

local current = current_git_common_dir()
if not current then return end

for entry in string.gmatch(raw, "[^;]+") do
	local git_dir, lua_path = entry:match("^([^|]+)|(.+)$")
	if git_dir and lua_path and normalize(git_dir) == current then
		local expanded = vim.fn.expand(lua_path)
		if vim.fn.filereadable(expanded) == 1 then
			local ok, err = pcall(dofile, expanded)
			if not ok then
				vim.notify(
					"Private module failed to load (" .. expanded .. "): " .. tostring(err),
					vim.log.levels.WARN
				)
			end
		end
	end
end
