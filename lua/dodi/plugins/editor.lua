local Util = require("dodi.util")

return {
	"christoomey/vim-tmux-navigator",
	"nvim-treesitter/nvim-treesitter-context",

	{
		"smithbm2316/centerpad.nvim",
		cmd = "Centerpad",
		keys = {
			{
				"<leader>ch",
				function()
					require("centerpad").toggle({
						leftpad = math.ceil((vim.api.nvim_win_get_width(0) - 120) / 2),
						rightpad = math.ceil((vim.api.nvim_win_get_width(0) - 120) / 2),
					})
				end,
				desc = "Center horizontally",
				silent = true,
				noremap = true,
			},
		},
	},

	{
		"ThePrimeagen/harpoon",
		opts = {
			tabline = false,
			menu = {
				width = math.ceil(vim.api.nvim_win_get_width(0) * 0.8),
			},
		},
		keys = {
			{
				"<leader>hg",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add to Harpoon",
			},
			{
				"<leader>he",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Open Harpoon quick menu",
			},
			{
				"<leader>ha",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Navigate to file 1",
			},
			{
				"<leader>hr",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Navigate to file 2",
			},
			{
				"<leader>hs",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Navigate to file 3",
			},
			{
				"<leader>ht",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Navigate to file 4",
			},
			{
				"<leader>hz",
				function()
					require("harpoon.ui").nav_file(5)
				end,
				desc = "Navigate to file 5",
			},
			{
				"<leader>hx",
				function()
					require("harpoon.ui").nav_file(6)
				end,
				desc = "Navigate to file 6",
			},
			{
				"<leader>hc",
				function()
					require("harpoon.ui").nav_file(7)
				end,
				desc = "Navigate to file 7",
			},
			{
				"<leader>hd",
				function()
					require("harpoon.ui").nav_file(8)
				end,
				desc = "Navigate to file 8",
			},
		},
	},

	{
		"nvim-pack/nvim-spectre",
		lazy = true,
		keys = {
			{ "<leader>sr", '<cmd>lua require("spectre").open()<CR>', desc = "Open spectre" },
		},
	},

	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		opts = { app = "browser" },
		keys = {
			{
				"<leader>mp",
				function()
					local peek = require("peek")
					if peek.is_open() then
						peek.close()
					else
						peek.open()
					end
				end,
				desc = "Peek Open",
			},
		},
	},

	{
		-- file explorer
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						dir = require("dodi.util").get_root(),
						reveal = true,
					})
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>E",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						dir = vim.loop.cwd(),
						reveal = true,
					})
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			event_handlers = {
				-- close explorer when opening a file
				{
					event = "file_opened",
					handler = function()
						require("neo-tree").close_all()
					end,
				},
			},
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = true,
			},
			window = {
				position = "current",
				width = 100,
				mappings = {
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			"smilovanovic/telescope-search-dir-picker.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader><leader>", Util.telescope("files", { cwd = false }), desc = "Find Files (root dir)" },
			{ "<leader>ff", Util.telescope("files"), desc = "Find Files (cwd)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			-- search
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>sf", "<cmd>Telescope search_dir_picker<cr>", desc = "Grep (choose dir)" },
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (cwd)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (root dir)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{
				"<leader>sH",
				"<cmd>Telescope highlights<cr>",
				desc = "Search Highlight Groups",
			},
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
			{
				"<leader>ss",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				Util.telescope("lsp_workspace_symbols", {

					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		config = function()
			local telescope = require("telescope")
			local trouble = require("trouble.providers.telescope")

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			})
			telescope.load_extension("search_dir_picker")
			telescope.load_extension("fzf")
		end,
	},

	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/flit.nvim",
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			local keymaps = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>h"] = { name = "+harpoon" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>d"] = { name = "+debugger" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
				["<leader>n"] = { name = "+neorg" },
			}
			wk.register(keymaps)
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		"aspeddro/gitui.nvim",
		opts = {},
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	-- buffer remove
	{
		"kazhala/close-buffers.nvim",
		keys = {
			{ "<leader>bc", ":BDelete this<cr>", silent = true },
			{ "<leader>ba", ":BWipeout all<cr>", silent = true },
			{ "<leader>bo", ":BWipeout other<cr>:e<cr>", silent = true },
		},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
	},

	{
		"mbbill/undotree",
		lazy = true,
		keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" } },
	},

	{
		"smjonas/inc-rename.nvim",
		lazy = true,
		keys = {
			{ "<leader>cr", ":IncRename ", desc = "Rename" },
			{
				"<leader>cs",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "Rename (fill in word)",
				expr = true,
			},
		},
		opts = {},
	},

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
		keys = {
			{ "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg index" },
			{ "<leader>nt", "<cmd>Neorg journal<cr>", desc = "Neorg journal" },
		},
		opts = {
			load = {
				["core.defaults"] = {},
				["core.journal"] = { config = { workspace = "personal" } },
				["core.concealer"] = { config = { folds = false } },
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.keybinds"] = {
					config = {
						hook = function(keybinds)
							keybinds.map("norg", "n", "<localleader>r", "<cmd>Neorg return<CR>")
						end,
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							personal = "~/OneDrive/Documents/notes/personal",
							work = "~/OneDrive/Documents/notes/work",
						},
						default_workspace = "work",
					},
				},
				["core.integrations.telescope"] = {},
			},
		},
		config = function(_, opts)
			local neorg_callbacks = require("neorg.callbacks")
			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				keybinds.map_event_to_mode("norg", {
					n = {
						{ "<localleader>f", "core.integrations.telescope.find_linkable" },
						{ "<C-l>", "core.integrations.telescope.insert_link" },
					},
					i = {
						{ "<C-l>", "core.integrations.telescope.insert_link" },
					},
				}, { silent = true, noremap = true })
			end)
			require("neorg").setup(opts)
		end,
	},
}
