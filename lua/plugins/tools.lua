-- Misc tools
return {
	-- Multicursor
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			local set = vim.keymap.set

			set({ "n", "x" }, "<up>", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "x" }, "<down>", function()
				mc.lineAddCursor(1)
			end)

			set({ "n", "x" }, "<C-n>", function()
				mc.matchAddCursor(1)
			end, { desc = "Add cursor matching word, next" })
			set({ "n", "x" }, "<C-p>", function()
				mc.matchAddCursor(-1)
			end, { desc = "Add cursor matching word, prev" })

			set({ "n", "x" }, "<left>", mc.nextCursor, { desc = "Rotate to next cursor" })
			set({ "n", "x" }, "<right>", mc.prevCursor, { desc = "Rotate to previous cursor" })

			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			set({ "n", "x" }, "<leader>cx", mc.toggleCursor, { desc = "Toggle cursor at current position" })

			set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					vim.cmd("nohlsearch")
				end
			end)

			set("n", "<leader>cr", mc.restoreCursors, { desc = "Restore previously cleared cursors" })
			set("n", "<leader>ca", mc.alignCursors, { desc = "Align all cursor columns" })

			set("x", "I", mc.insertVisual)
			set("x", "A", mc.appendVisual)

			set({ "x", "n" }, "<c-i>", mc.jumpForward)
			set({ "x", "n" }, "<c-o>", mc.jumpBackward)

			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},

	-- Snacks (image support etc.)
	{
		"folke/snacks.nvim",
		priority = 1000,
		config = function()
			require("snacks").setup({
				styles = {
					snacks_image = {
						relative = "cursor",
						border = "single",
						focusable = false,
						backdrop = false,
						row = 1,
						col = 1,
					},
				},
				image = {
					doc = {
						enabled = true,
						inline = false,
						float = true,
						max_width = 50,
						max_height = 50,
					},
				},
			})
		end,
	},

	-- 99 (AI)
	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				provider = _99.OpenCodeProvider,
				model = "cursor/auto",
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},

				completion = {
					custom_rules = {
						"scratch/custom_rules/",
					},

					files = {},

					source = "blink",
				},

				md_files = {
					"AGENT.md",
				},
			})

			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end)

			vim.keymap.set("v", "<leader>9s", function()
				_99.stop_all_requests()
			end)
		end,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
