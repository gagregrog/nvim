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

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		keymap.nmap(
			"<leader>lf",
			"mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F | :w<CR>",
			"Fix current file"
		)

		keymap.nmap("<leader>l", function()
			lint.try_lint()
		end, "Trigger linting for current file")
	end,
}
