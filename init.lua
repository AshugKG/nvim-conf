-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- so terminal isn't discarded when toggled
vim.opt.hidden = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Tabs are spaces
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.softtabstop = 4 -- Number of spaces per Tab key press

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- textwidth (auto wrap?)
-- vim.opt.textwidth = 80

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- vim.g.neovide_position_animation_length = 0
-- vim.g.neovide_cursor_animation_length = 0.00
-- vim.g.neovide_cursor_trail_size = 0
-- vim.g.neovide_cursor_animate_in_insert_mode = false
-- vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_scroll_animation_far_lines = 0
-- vim.g.neovide_scroll_animation_length = 0.00

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- kj -> esc
vim.keymap.set("i", "kj", "<Esc>")

-- -- jk -> esc but rightward (kinda useless lmao)
-- vim.keymap.set("i", "jk", "<Esc>l")

vim.keymap.set("n", "s", "<Nop>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Vim project based (START)
vim.opt.exrc = true
vim.opt.secure = true
local workspace_path = vim.fn.getcwd()
local cache_dir = vim.fn.stdpath("data")
local project_name = vim.fn.fnamemodify(workspace_path, ":t")
local project_dir = cache_dir .. "/myshada/" .. project_name
if vim.fn.isdirectory(project_dir) == 0 then
	vim.fn.mkdir(project_dir, "p")
end
local shadafile = project_dir .. "/" .. vim.fn.sha256(workspace_path):sub(1, 8) .. ".shada"
vim.opt.shadafile = shadafile
-- Vim project based (END)

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- numbered jumps to jl
vim.keymap.set("n", "k", function()
	return (vim.v.count > 1 and "m'" .. vim.v.count or "") .. "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
	return (vim.v.count > 1 and "m'" .. vim.v.count or "") .. "j"
end, { expr = true })

-- NOTE: Keep ALL LINE INSERTIONS HERE

-- workarounds for autoindenting deleting whitespace.
-- inspo: https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
vim.keymap.set("n", "o", "o<Space><BS>")
vim.keymap.set("n", "O", "O<Space><BS>")
vim.keymap.set("i", "<CR>", "<CR><Space><BS>")
-- enter and shift enter to do insert newline without leaving normal mode
vim.keymap.set("n", "<CR>", function()
	if vim.fn.getcmdwintype() == "" and vim.bo.filetype ~= "qf" then
		return "o<Space><BS><Esc>"
	else
		return "<CR>"
	end
end, { expr = true })

vim.keymap.set("n", "<S-CR>", function()
	if vim.fn.getcmdwintype() == "" and vim.bo.filetype ~= "qf" then
		return "O<Space><BS><Esc>"
	else
		return "<S-CR>"
	end
end, { expr = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
	--

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do

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

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	opts = {
	-- 		enable = true, -- Enable this plugin (can be toggled later via commands)
	-- 		multiwindow = true, -- Enable multiwindow support
	-- 		max_lines = 2, -- No limit on the number of context lines
	-- 		min_window_height = 0, -- No minimum window height required to show context
	-- 		line_numbers = true, -- Show line numbers in context
	-- 		multiline_threshold = 10, -- Max lines for a single context
	-- 		trim_scope = "inner", -- Trim outer context if max_lines is exceeded
	-- 		mode = "topline", -- Context based on cursor position
	-- 		separator = nil, -- No separator between context and content
	-- 		zindex = 20, -- Z-index of the context window
	-- 		on_attach = nil, -- Optional: return false to disable attaching for certain buffers
	-- 	},
	-- },

	-- soft/hardwrap on writing
	{
		"preservim/vim-pencil",
	},

	-- fixes unnamedplus lag -- Seems to not support tmux
	-- {
	-- 	"EtiamNullam/deferred-clipboard.nvim",
	-- 	config = function()
	-- 		require("deferred-clipboard").setup()
	-- 	end,
	-- },

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

	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},

	{ "lark-parser/vim-lark-syntax" },

	-- easier motion through camelCase
	-- { "chaoren/vim-wordmotion" },

	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("harpoon").setup()
	-- 		local mark = require("harpoon.mark")
	-- 		local ui = require("harpoon.ui")
	-- 		local term = require("harpoon.term")
	--
	-- 		vim.keymap.set("n", "<leader>mf", mark.add_file, { desc = "Harpoon: [m]ark [f]ile" })
	-- 		vim.keymap.set("n", "<leader>me", ui.toggle_quick_menu, { desc = "Harpoon: [me]nu" })
	-- 		vim.keymap.set("n", "<leader>1", function()
	-- 			ui.nav_file(1)
	-- 		end, { desc = "Harpoon: file 1" })
	-- 		vim.keymap.set("n", "<leader>2", function()
	-- 			ui.nav_file(2)
	-- 		end, { desc = "Harpoon: file 2" })
	-- 		vim.keymap.set("n", "<leader>3", function()
	-- 			ui.nav_file(3)
	-- 		end, { desc = "Harpoon: file 3" })
	-- 		vim.keymap.set("n", "<leader>4", function()
	-- 			ui.nav_file(4)
	-- 		end, { desc = "Harpoon: file 4" })
	-- 	end,
	-- },
	{ -- Commented until i figure our nohlsearch
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			local set = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			set({ "n", "x" }, "<up>", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "x" }, "<down>", function()
				mc.lineAddCursor(1)
			end)
			-- set({ "n", "x" }, "<leader><up>", function()
			-- 	mc.lineSkipCursor(-1)
			-- end)
			-- set({ "n", "x" }, "<leader><down>", function()
			-- 	mc.lineSkipCursor(1)
			-- end)

			-- Add or skip adding a new cursor by matching word/selection
			set({ "n", "x" }, "<C-n>", function()
				mc.matchAddCursor(1)
			end, { desc = "Add cursor matching word, next" })
			-- set({ "n", "x" }, "<leader>ms", function()
			-- 	mc.matchSkipCursor(1)
			-- end)
			set({ "n", "x" }, "<C-p>", function()
				mc.matchAddCursor(-1)
			end, { desc = "Add cursor matching word, prev" })
			-- set({ "n", "x" }, "<leader>mS", function()
			-- 	mc.matchSkipCursor(-1)
			-- end)

			-- In normal/visual mode, press `mwap` will create a cursor in every match of
			-- the word captured by `iw` (or visually selected range) inside the bigger
			-- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
			-- set({ "n", "x" }, "mw", function()
			-- 	mc.operator({ motion = "iw", visual = true })
			-- 	-- Or you can pass a pattern, press `mwi{` will select every \w,
			-- 	-- basically every char in a `{ a, b, c, d }`.
			-- 	-- mc.operator({ pattern = [[\<\w]] })
			-- end)

			-- -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
			-- set("n", "mW", mc.operator)

			-- -- Add all matches in the document
			-- set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

			-- -- You can also add cursors with any motion you prefer:
			-- set("n", "<right>", function()
			-- 	mc.addCursor("w")
			-- end)
			-- set("n", "<leader><right>", function()

			-- end)

			-- Rotate the main cursor.
			set({ "n", "x" }, "<left>", mc.nextCursor, { desc = "Rotate to next cursor" })
			set({ "n", "x" }, "<right>", mc.prevCursor, { desc = "Rotate to previous cursor" })

			-- -- Delete the main cursor.
			-- set({ "n", "x" }, "<leader>mx", mc.deleteCursor)

			-- Add and remove cursors with control + left click.
			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Easy way to add and remove cursors using the main cursor.
			set({ "n", "x" }, "<leader>cx", mc.toggleCursor, { desc = "Toggle cursor at current position" })

			-- -- Clone every cursor and disable the originals.
			-- set({ "n", "x" }, "<leader>mc", mc.duplicateCursors)

			set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
					vim.cmd("nohlsearch")
				end
			end)

			-- bring back cursors if you accidentally clear them
			set("n", "<leader>cr", mc.restoreCursors, { desc = "Restore previously cleared cursors" })

			-- Align cursor columns.
			set("n", "<leader>ca", mc.alignCursors, { desc = "Align all cursor columns" })

			-- -- Split visual selections by regex.
			-- set("x", "S", mc.splitCursors)

			-- Append/insert for each line of visual selections.
			set("x", "I", mc.insertVisual)
			set("x", "A", mc.appendVisual)

			-- -- match new cursors within visual selections by regex.
			-- set("x", "M", mc.matchCursors)
			--
			-- -- Rotate visual selection contents.
			-- set("x", "<leader>t", function()
			-- 	mc.transposeCursors(1)
			-- end)
			-- set("x", "<leader>T", function()
			-- 	mc.transposeCursors(-1)
			-- end)

			-- Jumplist support
			set({ "x", "n" }, "<c-i>", mc.jumpForward)
			set({ "x", "n" }, "<c-o>", mc.jumpBackward)

			-- Customize how cursors look.
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

	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",

			-- optional dependencies:

			-- a completion engine
			--    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

			-- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
			-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
			-- 'andrewradev/switch.vim',        -- for switch support
			-- 'tomtom/tcomment_vim',           -- for commenting
		},

		---@type lean.Config
		opts = { -- see below for full configuration options
			mappings = true,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			map_cr = false,
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			-- rebinds enter with the autoindenting deleting whitespace fix
			vim.api.nvim_set_keymap(
				"i",
				"<CR>",
				[[v:lua.require'nvim-autopairs'.completion_confirm() .. '<Space><BS>']],
				{ expr = true, noremap = true }
			)
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						-- Example keymaps
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, buffer = bufnr })

						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { silent = true, buffer = bufnr })
					end,
				},
			}
		end,
	},
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
						-- width/height are automatically set by the image size unless specified below
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

	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

			-- For logging that is to a file if you wish to trace through requests
			-- for reporting bugs, i would not rely on this, but instead the provided
			-- logging mechanisms within 99.  This is for more debugging purposes
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				provider = _99.OpenCodeProvider, -- default: OpenCodeProvider
				model = "cursor/auto",
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},

				--- Completions: #rules and @files in the prompt buffer
				completion = {
					-- I am going to disable these until i understand the
					-- problem better.  Inside of cursor rules there is also
					-- application rules, which means i need to apply these
					-- differently
					-- cursor_rules = "<custom path to cursor rules>"

					--- A list of folders where you have your own SKILL.md
					--- Expected format:
					--- /path/to/dir/<skill_name>/SKILL.md
					---
					--- Example:
					--- Input Path:
					--- "scratch/custom_rules/"
					---
					--- Output Rules:
					--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
					--- ... the other rules in that dir ...
					---
					custom_rules = {
						"scratch/custom_rules/",
					},

					--- Configure @file completion (all fields optional, sensible defaults)
					files = {
						-- enabled = true,
						-- max_file_size = 102400,     -- bytes, skip files larger than this
						-- max_files = 5000,            -- cap on total discovered files
						-- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
					},

					--- What autocomplete do you use.  We currently only
					--- support cmp right now
					source = "cmp",
				},

				--- WARNING: if you change cwd then this is likely broken
				--- ill likely fix this in a later change
				---
				--- md_files is a list of files to look for and auto add based on the location
				--- of the originating request.  That means if you are at /foo/bar/baz.lua
				--- the system will automagically look for:
				--- /foo/bar/AGENT.md
				--- /foo/AGENT.md
				--- assuming that /foo is project root (based on cwd)
				md_files = {
					"AGENT.md",
				},
			})

			-- take extra note that i have visual selection only in v mode
			-- technically whatever your last visual selection is, will be used
			-- so i have this set to visual mode so i dont screw up and use an
			-- old visual selection
			--
			-- likely ill add a mode check and assert on required visual mode
			-- so just prepare for it now
			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end)

			--- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("v", "<leader>9s", function()
				_99.stop_all_requests()
			end)
		end,
	},
	-- -- better netrw
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = { delete_to_trash = false },
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({})

			vim.keymap.set("n", "-", require("oil").open, { desc = "Open Oil File Explorer" })
		end,
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- yank doesn't move cursor
	{
		"svban/YankAssassin.nvim",
		config = function()
			require("YankAssassin").setup({
				auto_normal = true, -- if true, autocmds are used. Whenever y is used in normal mode, the cursor doesn't move to start
				auto_visual = true, -- if true, autocmds are used. Whenever y is used in visual mode, the cursor doesn't move to start
			})
		end,
	},

	{
		"bassamsdata/namu.nvim",
		config = function()
			require("namu").setup({
				-- Enable the modules you want
				namu_symbols = {
					enable = true,
					options = {}, -- here you can configure namu
				},
				-- Optional: Enable other modules if needed
				ui_select = { enable = false }, -- vim.ui.select() wrapper
				colorscheme = {
					enable = false,
					options = {
						-- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
						persist = true, -- very efficient mechanism to Remember selected colorscheme
						write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
					},
				},
			})
			-- === Suggested Keymaps: ===
			vim.keymap.set("n", "<leader>ds", ":Namu symbols<cr>", {
				desc = "Jump to LSP symbol",
				silent = true,
			})
		end,
	},

	-- ssh lag removal
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},

	-- prevent vim from autoscrolling on buffer swap
	{
		"BranimirE/fix-auto-scroll.nvim",
		config = true,
		event = "VeryLazy",
	},

	-- nui (some dependency)
	{ "MunifTanjim/nui.nvim" },

	-- -- tab does multiple tabs accordingly so i don't have to spam (buggy so commented)
	-- {
	-- 	"vidocqh/auto-indent.nvim",
	-- 	opts = {},
	-- },

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			-- "TmuxNavigatePrevious",
			-- "TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			-- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- -- Smooth scrolling (neoscroll)
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	config = function()
	-- 		require("neoscroll").setup({
	-- 			-- Correctly structured options
	-- 			mappings = { "zt", "zz", "zb", "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
	-- 			hide_cursor = true, -- Hide cursor while scrolling
	-- 			stop_eof = true, -- Stop at <EOF> when scrolling downwards
	-- 			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	-- 			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	-- 			duration_multiplier = 0.1, -- Global duration multiplier
	-- 			easing_function = "linear", -- Default easing function
	-- 			pre_hook = nil, -- Function to run before the scrolling animation starts
	-- 			post_hook = nil, -- Function to run after the scrolling animation ends
	-- 			performance_mode = true, -- Disable "Performance Mode" on all buffers
	-- 			ignored_events = { -- Events ignored while scrolling
	-- 				"WinScrolled",
	-- 				"CursorMoved",
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- Leetcode
	-- {
	-- 	"kawre/leetcode.nvim",
	-- 	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 		-- "ibhagwan/fzf-lua",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	opts = {
	-- 		lang = "python3",
	-- 		image_support = false, -- wrap issue
	-- 		theme = {
	-- 			["normal"] = {
	-- 				fg = "#3b3b3b",
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- 	---@module 'render-markdown'
	-- 	---@type render.md.UserConfig
	-- 	opts = {},
	-- },

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"numToStr/Comment.nvim",
		opts = {}, -- Use default configuration
	},

	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		lazy = true,
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-e>"] = { "hide" },
				["<C-Space>"] = { "show" },
				["<C-y>"] = { "accept" }, -- accept completion
			},
			cmdline = {
				completion = {
					menu = {
						auto_show = function()
							return vim.fn.getcmdtype() == ":"
						end,
					},
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			signature = { enabled = true },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "normal",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer", "omni" },
			},
		},
		opts_extend = { "sources.default" },
	},

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			preset = "helix",

			win = {
				wo = {
					-- winblend = 100,
				},
			},
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
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
			-- Document existing key chains
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

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			{
				-- search grep args (like search within files of certain extension)
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				defaults = {
					vimgrep_arguments = {
						-- all required except `--smart-case`
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",

						-- add your options
					},
					mappings = {
						-- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					},
				},
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "live_grep_args")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end, { desc = "[S]earch by [G]rep with arguments" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	-- marks addons
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = true,
		},
	},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			-- General settings for fold behavior
			-- vim.o.foldcolumn = '1' -- '0' is also fine if you prefer no column
			vim.o.foldlevel = 99 -- High value for using the ufo provider
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Key mappings for folding
			vim.keymap.set("n", "zO", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "Close all folds" })

			-- ufo plugin setup
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- -- Useful status updates for LSP.
			-- -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			-- { "j-hui/fidget.nvim", opts = {} },

			-- blink.cmp extends vim.lsp.config('*') with completion capabilities (0.11+)
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

			-- ── mason-lspconfig: install + enable via 0.11 API ──
			require("mason-lspconfig").setup({
				ensure_installed = { "tinymist", "basedpyright", "lua_ls" },
				handlers = {
					function(server_name)
						vim.lsp.enable(server_name)
					end,
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Non-LSP tools only; LSP list is mason-lspconfig.ensure_installed above.
					-- "stylua",
					-- "ruff",
				},
			})

			-- Homebrew clangd (not necessarily installed via Mason)
			vim.lsp.enable("clangd")
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use :Telescope colorscheme.
		"EdenEast/nightfox.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("dawnfox")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- code in md files is indented based on the code lang
	{
		"wurli/contextindent.nvim",
		-- This is the only config option; you can use it to restrict the files
		-- which this plugin will affect (see :help autocommand-pattern).
		opts = { pattern = "*" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({
				n_lines = 500,
				custom_textobjects = {
					f = require("mini.ai").gen_spec.treesitter({
						a = "@function.outer", -- Selects the whole function (with keyword, body, etc.)
						i = "@function.inner", -- Selects the inside of the function (just the body)
					}),
					c = require("mini.ai").gen_spec.treesitter({
						a = "@class.outer", -- Selects the whole function (with keyword, body, etc.)
						i = "@class.inner", -- Selects the inside of the function (just the body)
					}),
				},
			})
			-- require("mini.completion").setup() -- signatures mini version
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				mappings = {
					add = "s",
				},
			})

			require("mini.bracketed").setup()
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"python",
				"sql",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter", -- Load after nvim-treesitter
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- },
	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require("kickstart.plugins.lint"),
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	-- { import = 'custom.plugins' },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
