return {
	-- { "xiyaowong/transparent.nvim" },

	{
		"rose-pine/neovim",
		priority = 1000,
		lazy = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({ disable_italics = true })
			-- vim.cmd("colorscheme rose-pine")
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				theme = "dragon",
				background = { dark = "dragon", light = "lotus" },
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},

	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		config = function()
			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.api.nvim_set_option("background", "dark")
					vim.cmd("colorscheme kanagawa")
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					vim.cmd("colorscheme rose-pine")
				end,
			})

			auto_dark_mode.init()
		end,
	},
}
