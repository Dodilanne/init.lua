return {
	{
		"tpope/vim-dadbod",
		keys = {
			{ "<leader>da", ":DBUIToggle<cr>", desc = "Open database UI" },
		},
		config = function()
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql" },
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					vim.schedule(function()
						-- Setup db completions
						require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
					end)
				end,
			})
		end,
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
	},
}
