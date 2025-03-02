return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = true, -- show line blame by default
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local map = require("gagregrog.core.keymap")
			local opts = { buffer = bufnr }

			-- Navigation
			map.nmap("]g", gs.next_hunk, "Next Hunk", opts)
			map.nmap("[g", gs.prev_hunk, "Prev Hunk", opts)

			-- Actions
			map.nmap("<leader>gs", gs.stage_hunk, "Stage hunk", opts)
			map.nmap("<leader>gr", gs.reset_hunk, "Reset hunk", opts)
			map.vmap("<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk", opts)
			map.vmap("<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk", opts)

			map.nmap("<leader>gS", gs.stage_buffer, "Stage entire buffer", opts)
			map.nmap("<leader>gR", gs.reset_buffer, "Reset entire buffer", opts)

			map.nmap("<leader>gu", gs.undo_stage_hunk, "Undo stage hunk", opts)

			map.nmap("<leader>gp", gs.preview_hunk, "Preview hunk", opts)

			map.nmap("<leader>gb", function()
				gs.blame_line({ full = true })
			end, "Blame line", opts)
			map.nmap("<leader>gB", gs.toggle_current_line_blame, "Toggle line blame", opts)

			map.nmap("<leader>gd", gs.diffthis, "Diff this", opts)
			map.nmap("<leader>gD", function()
				gs.diffthis("~")
			end, "Diff this ~", opts)

			map.nmap("<leader>gv", gs.setqflist, "Set changes to quickfix list", opts)

			-- Text object
			map.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk", opts)
		end,
	},
}
