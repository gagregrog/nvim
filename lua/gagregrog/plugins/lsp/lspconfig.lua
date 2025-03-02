return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = require("gagregrog.core.keymap")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }

				-- set keybinds
				keymap.nmap("gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references", opts) -- show definition, references

				keymap.nmap("gD", vim.lsp.buf.declaration, "Go to declaration", opts) -- go to declaration

				keymap.nmap("gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions", opts) -- show lsp definitions

				keymap.nmap("gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations", opts) -- show lsp implementations

				keymap.nmap("gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions", opts) -- show lsp type definitions

				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions", opts) -- see available code actions, in visual mode will apply to selection

				keymap.nmap("<leader>rn", vim.lsp.buf.rename, "Smart rename", opts) -- smart rename

				keymap.nmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics", opts) -- show  diagnostics for file

				keymap.nmap("<leader>d", vim.diagnostic.open_float, "Show line diagnostics", opts) -- show diagnostics for line

				keymap.nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic", opts) -- jump to previous diagnostic in buffer

				keymap.nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic", opts) -- jump to next diagnostic in buffer

				keymap.nmap("K", vim.lsp.buf.hover, "Show documentation for what is under cursor", opts) -- show documentation for what is under cursor

				keymap.nmap("<leader>rs", ":LspRestart<CR>", "Restart LSP", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["ts_ls"] = function()
				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					filetypes = { "typescript", "typescriptreact" },
					init_options = {
						preferences = {
							importModuleSpecifierPreference = "non-relative",
						},
					},
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
