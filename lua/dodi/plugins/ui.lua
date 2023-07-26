return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "dashboard", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = true,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				globalstatus = true,
			},
		},
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{ "MunifTanjim/nui.nvim", lazy = true },
}
