return {
	{
		"ThePrimeagen/vim-be-good",
		lazy = true,
		cmd = "VimBeGood",
	},

	{
		"folke/zen-mode.nvim",
		lazy = true,
		keys = {
			{ "<leader>zm", ":ZenMode<cr>", desc = "Increment selection" },
		},
		opts = {
			window = {
				width = 120,
				options = {
					number = true,
				},
			},
			plugins = {},
		},
	},
}
