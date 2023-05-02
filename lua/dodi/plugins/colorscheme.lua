return {
	{ "xiyaowong/transparent.nvim" },
	{
		"rose-pine/neovim",
		priority = 1000,
		lazy = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_italics = true,
			})
			vim.cmd("colorscheme rose-pine")
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
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
				end,
			})

			auto_dark_mode.init()
		end,
	},
}
