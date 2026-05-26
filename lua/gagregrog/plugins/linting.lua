return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local keymap = require("gagregrog.core.keymap")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "pylint" },
		}

		local eslint_root_markers = {
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc",
		}

		local function try_lint()
			local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
			local uses_eslint = vim.tbl_contains(linters, "eslint_d")
			if uses_eslint then
				local root = vim.fs.root(0, eslint_root_markers)
				if root then
					lint.try_lint(nil, { cwd = root })
					return
				end
			end
			lint.try_lint()
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = try_lint,
		})

		local function eslint_fix()
			local root = vim.fs.root(0, eslint_root_markers)
			if not root then
				vim.notify("eslint_d: no eslint config found", vim.log.levels.WARN)
				return
			end

			local filename = vim.api.nvim_buf_get_name(0)
			local input = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
			local result = vim.system(
				{ "eslint_d", "--stdin", "--fix-to-stdout", "--stdin-filename", filename },
				{ stdin = input, cwd = root, text = true }
			):wait()

			if result.code ~= 0 or not result.stdout or result.stdout == "" then
				local msg = (result.stderr ~= "" and result.stderr) or result.stdout or "unknown error"
				vim.notify("eslint_d failed:\n" .. msg, vim.log.levels.ERROR)
				return
			end

			local cursor = vim.api.nvim_win_get_cursor(0)
			local output = vim.split(result.stdout, "\n", { plain = true })
			if output[#output] == "" then
				table.remove(output)
			end
			vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
			pcall(vim.api.nvim_win_set_cursor, 0, cursor)
			vim.cmd("write")
		end

		keymap.nmap("<leader>lf", eslint_fix, "Fix current file")

		keymap.nmap("<leader>l", try_lint, "Trigger linting for current file")
	end,
}
