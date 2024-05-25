return {
  "alexghergh/nvim-tmux-navigation", -- tmux & split window navigation
  config = function()
    local keymap = vim.keymap
    local vtm = require("nvim-tmux-navigation")
    vtm.setup({
      disable_when_zoomed = true
    })

    keymap.set('n', "<leader>nf", vtm.NvimTmuxNavigateUp, { desc = "Navigate up from current split" })
    keymap.set('n', "<C-k>", vtm.NvimTmuxNavigateUp, { desc = "Navigate up from current split" })
    keymap.set('n', "<leader>ns", vtm.NvimTmuxNavigateDown, { desc = "Navigate down from current split" })
    keymap.set('n', "<C-j>", vtm.NvimTmuxNavigateDown, { desc = "Navigate down from current split" })
    keymap.set('n', "<leader>nr", vtm.NvimTmuxNavigateLeft, { desc = "Navigate left from current split" })
    keymap.set('n', "<C-h>", vtm.NvimTmuxNavigateLeft, { desc = "Navigate left from current split" })
    keymap.set('n', "<leader>nt", vtm.NvimTmuxNavigateRight, { desc = "Navigate right from current split" })
    keymap.set('n', "<C-l>", vtm.NvimTmuxNavigateRight, { desc = "Navigate right from current split" })
    keymap.set('n', "<leader>np", vtm.NvimTmuxNavigateLastActive, { desc = "Navigate to previous split" })
    keymap.set('n', "<leader>nn", vtm.NvimTmuxNavigateNext, { desc = "Navigate to next split" })
  end,
}
