return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "H", "<Cmd>BufferLineCyclePrev<CR>", desc = "Go to previous buffer" },
			{ "L", "<Cmd>BufferLineCycleNext<CR>", desc = "Go to next buffer" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		keys = {
			{ "<leader>aa", "<Cmd>Alpha<CR>", desc = "Open dashboard" },
		},
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[ 
 ██████╗  ██████╗ ██████╗ ██╗██╗   ██╗██╗███╗   ███╗
 ██╔══██╗██╔═══██╗██╔══██╗██║██║   ██║██║████╗ ████║
 ██║  ██║██║   ██║██║  ██║██║██║   ██║██║██╔████╔██║
 ██║  ██║██║   ██║██║  ██║██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██████╔╝╚██████╔╝██████╔╝██║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("g", " " .. " Git", ":Gitui<CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
}
