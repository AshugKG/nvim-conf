-- Visual / UI plugins
return {
	-- Colorscheme
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dawnfox")
			vim.cmd.hi("Comment gui=none")
		end,
	},

	-- Pending keybinds
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			preset = "helix",

			win = {
				wo = {},
			},
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			show_help = false,
			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	{ "HiPhish/rainbow-delimiters.nvim" },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- mini.nvim collection
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({
				n_lines = 500,
				custom_textobjects = {
					f = require("mini.ai").gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}),
					c = require("mini.ai").gen_spec.treesitter({
						a = "@class.outer",
						i = "@class.inner",
					}),
				},
			})

			require("mini.surround").setup({
				mappings = {
					add = "s",
				},
			})

			require("mini.bracketed").setup()

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
