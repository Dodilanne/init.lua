return {
	{
		"rose-pine/neovim",
		priority = 1000,
		lazy = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup()
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
					-- vim.cmd(string.format("colorscheme %s", dark_theme))
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					-- vim.cmd(string.format("colorscheme %s", light_theme))
				end,
			})

			auto_dark_mode.init()
		end,
	},
}
