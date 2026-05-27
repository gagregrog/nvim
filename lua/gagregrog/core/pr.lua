local M = {}

-- Cache of branch → PR base ref name. Same branch = same PR base, so we only
-- shell out to `gh` once per branch per session.
local pr_base_cache = {}

local function current_branch()
	local res = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
	if res.code ~= 0 then
		return nil
	end
	local b = (res.stdout or ""):gsub("%s+", "")
	if b == "" or b == "HEAD" then
		return nil
	end
	return b
end

-- Point gitsigns at the current branch's PR base ref so signs in the gutter
-- reflect what the PR changed (vs. the index).
--   opts.force_notify: notify on success even on cache hit. Default false —
--                      cache hits stay silent so repeated `gf`s don't spam.
-- Returns the full ref (e.g. "origin/main") on success, nil otherwise.
function M.sync_gitsigns_base(opts)
	opts = opts or {}
	local branch = current_branch()
	if not branch then
		vim.notify("Not on a branch", vim.log.levels.WARN)
		return nil
	end
	local cached = pr_base_cache[branch]
	local base = cached
	if not base then
		local res = vim
			.system({ "gh", "pr", "view", "--json", "baseRefName", "--jq", ".baseRefName" }, { text = true })
			:wait()
		if res.code ~= 0 then
			vim.notify("No PR found for current branch", vim.log.levels.WARN)
			return nil
		end
		base = (res.stdout or ""):gsub("%s+", "")
		if base == "" then
			vim.notify("No PR base found", vim.log.levels.WARN)
			return nil
		end
		pr_base_cache[branch] = base
	end
	local ref = "origin/" .. base
	pcall(function()
		require("gitsigns").change_base(ref, true)
	end)
	if not cached or opts.force_notify then
		vim.notify("gitsigns base → " .. ref)
	end
	return ref
end

function M.reset_gitsigns_base()
	pcall(function()
		require("gitsigns").change_base(nil, true)
	end)
	vim.notify("gitsigns base reset")
end

return M
