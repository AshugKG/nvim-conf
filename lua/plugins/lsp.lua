-- LSP ecosystem
return {
	-- lazydev for Lua LSP in Neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- Main LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" }, -- setup is called explicitly in config below
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- ── Mason FIRST so its bin/ is on PATH before cmd resolution ──
			require("mason").setup()

			-- ── Load lspconfig defaults (registers cmd, filetypes, root_dir, etc.) ──
			require("lspconfig")

			vim.diagnostic.config({
				signs = true,
				underline = true,
				virtual_text = {
					severity = { min = vim.diagnostic.severity.HINT },
				},
				update_in_insert = false,
				severity_sort = true,
				float = {
					source = true,
				},
			})

			-- ── Per-server overrides (merged with lspconfig defaults) ──
			vim.lsp.config("tinymist", {
				settings = {
					formatterMode = "typstyle",
					exportPdf = "onType",
					semanticTokens = "disable",
				},
			})
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.config("clangd", {
				cmd = {
					"/opt/homebrew/opt/llvm/bin/clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
			})

			-- ── Autocommands ──
			local highlight_group = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			local detach_augroup = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true })
			vim.api.nvim_create_autocmd("LspDetach", {
				group = detach_augroup,
				callback = function(args)
					local bufnr = args.buf
					vim.lsp.buf.clear_references()
					for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
						if c.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
							return
						end
					end
					vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- ── mason-lspconfig: install + enable (default handler calls vim.lsp.enable) ──
			require("mason-lspconfig").setup({
				ensure_installed = { "tinymist", "basedpyright", "lua_ls" },
			})


			-- Homebrew clangd (not necessarily installed via Mason)
			vim.lsp.enable("clangd")
		end,
	},
}
