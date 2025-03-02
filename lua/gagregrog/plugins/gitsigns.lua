return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = true, -- show line blame by default
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local keymap = require("gagregrog.core.keymap")
			local opts = { buffer = bufnr }

			-- Navigation
			keymap.nmap("]g", gs.next_hunk, "Next Hunk", opts)
			keymap.nmap("[g", gs.prev_hunk, "Prev Hunk", opts)

			-- Actions
			keymap.nmap("<leader>gs", gs.stage_hunk, "Stage hunk", opts)
			keymap.nmap("<leader>gr", gs.reset_hunk, "Reset hunk", opts)
			keymap.vmap("<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk", opts)
			keymap.vmap("<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk", opts)

			keymap.nmap("<leader>gS", gs.stage_buffer, "Stage entire buffer", opts)
			keymap.nmap("<leader>gR", gs.reset_buffer, "Reset entire buffer", opts)

			keymap.nmap("<leader>gu", gs.undo_stage_hunk, "Undo stage hunk", opts)

			keymap.nmap("<leader>gp", gs.preview_hunk, "Preview hunk", opts)

			keymap.nmap("<leader>gb", function()
				gs.blame_line({ full = true })
			end, "Blame line", opts)
			keymap.nmap("<leader>gB", gs.toggle_current_line_blame, "Toggle line blame", opts)

			keymap.nmap("<leader>gd", gs.diffthis, "Diff this", opts)
			keymap.nmap("<leader>gD", function()
				gs.diffthis("~")
			end, "Diff this ~", opts)

			keymap.nmap("<leader>gv", gs.setqflist, "Set changes to quickfix list", opts)

			-- Text object
			keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk", opts)
		end,
	},
}
