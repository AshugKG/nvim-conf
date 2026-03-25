-- General editor enhancements
return {
	{ "numToStr/Comment.nvim", opts = {} },

	-- yank doesn't move cursor
	{
		"svban/YankAssassin.nvim",
		config = function()
			require("YankAssassin").setup({
				auto_normal = true,
				auto_visual = true,
			})
		end,
	},

	-- prevent vim from autoscrolling on buffer swap
	{
		"BranimirE/fix-auto-scroll.nvim",
		config = true,
		event = "VeryLazy",
	},

	-- marks addons
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = true,
		},
	},

	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},

	-- code in md files is indented based on the code lang
	{
		"wurli/contextindent.nvim",
		opts = { pattern = "*" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
