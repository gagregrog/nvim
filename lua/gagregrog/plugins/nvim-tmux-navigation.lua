return {
	"alexghergh/nvim-tmux-navigation", -- tmux & split window navigation
	config = function()
		local keymap = require("gagregrog.core.keymap")
		local vtm = require("nvim-tmux-navigation")
		vtm.setup({
			disable_when_zoomed = true,
		})

		-- Helper function to wrap around window navigation
		local function wrap_navigate(direction)
			local current_win = vim.api.nvim_get_current_win()
			local starting_win = current_win

			-- Try the normal navigation first
			if direction == "left" then
				vtm.NvimTmuxNavigateLeft()
			elseif direction == "right" then
				vtm.NvimTmuxNavigateRight()
			elseif direction == "up" then
				vtm.NvimTmuxNavigateUp()
			elseif direction == "down" then
				vtm.NvimTmuxNavigateDown()
			end

			-- If we didn't move, we hit an edge
			if vim.api.nvim_get_current_win() == starting_win then
				local wins = vim.api.nvim_tabpage_list_wins(0)
				if #wins <= 1 then
					return
				end

				-- Find the window to wrap to
				if direction == "left" then
					-- Wrap to rightmost window
					local rightmost = starting_win
					local rightmost_pos = -1
					for _, win in ipairs(wins) do
						local pos = vim.api.nvim_win_get_position(win)[2]
						if pos > rightmost_pos then
							rightmost = win
							rightmost_pos = pos
						end
					end
					vim.api.nvim_set_current_win(rightmost)
				elseif direction == "right" then
					-- Wrap to leftmost window
					local leftmost = starting_win
					local leftmost_pos = 9999
					for _, win in ipairs(wins) do
						local pos = vim.api.nvim_win_get_position(win)[2]
						if pos < leftmost_pos then
							leftmost = win
							leftmost_pos = pos
						end
					end
					vim.api.nvim_set_current_win(leftmost)
				elseif direction == "up" then
					-- Wrap to bottom window
					local bottom = starting_win
					local bottom_pos = -1
					for _, win in ipairs(wins) do
						local pos = vim.api.nvim_win_get_position(win)[1]
						if pos > bottom_pos then
							bottom = win
							bottom_pos = pos
						end
					end
					vim.api.nvim_set_current_win(bottom)
				elseif direction == "down" then
					-- Wrap to top window
					local top = starting_win
					local top_pos = 9999
					for _, win in ipairs(wins) do
						local pos = vim.api.nvim_win_get_position(win)[1]
						if pos < top_pos then
							top = win
							top_pos = pos
						end
					end
					vim.api.nvim_set_current_win(top)
				end
			end
		end

		keymap.nmap("<M-e>", vtm.NvimTmuxNavigateNext, "Navigate to the next split")
		keymap.nmap("<C-k>", function()
			wrap_navigate("up")
		end, "Navigate up from current split")
		keymap.nmap("<C-j>", function()
			wrap_navigate("down")
		end, "Navigate down from current split")
		keymap.nmap("<C-h>", function()
			wrap_navigate("left")
		end, "Navigate left from current split")
		keymap.nmap("<C-l>", function()
			wrap_navigate("right")
		end, "Navigate right from current split")
	end,
}
