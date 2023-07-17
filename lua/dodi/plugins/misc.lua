return {
	{
		"ThePrimeagen/vim-be-good",
		lazy = true,
		cmd = "VimBeGood",
	},

	{
		"eandrju/cellular-automaton.nvim",
		keys = {
			{ "<leader>mir", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" } },
			{ "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "Game of life" } },
		},
	},
}
