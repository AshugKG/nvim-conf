-- Navigation & buffer management
return {
	-- switch buffers quickly
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"<BS>",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = {
			sort = "last",
		},
	},

	-- better netrw
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = { delete_to_trash = false },
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup({})
			vim.keymap.set("n", "-", require("oil").open, { desc = "Open Oil File Explorer" })
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},

	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			require("dropbar").setup({
				bar = {
					pick = {
						pivots = "sadflewcmpghio",
					},
					truncate = true,
				},
			})

			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>dr", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		end,
	},
}
