return {
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "EdenEast/nightfox.nvim" },
		config = function()
			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.api.nvim_set_option("background", "dark")
					vim.cmd("colorscheme terafox")
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					vim.cmd("colorscheme dayfox")
				end,
			})

			auto_dark_mode.init()
		end,
	},

	{ "shaunsingh/nord.nvim", lazy = true },
	{ "Shatur/neovim-ayu", lazy = true },
}
