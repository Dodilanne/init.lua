return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>ds",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>dj",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>dk",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>di",
				function()
					require("dap").repl.open()
				end,
				desc = "Inspect state",
			},
		},
		config = function()
			local dap = require("dap")

			-- Godot
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}
			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
					launch_scene = true,
				},
			}
		end,
	},
}
