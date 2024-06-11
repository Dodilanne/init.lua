return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>gb",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>gs",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>gj",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>gk",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>gi",
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
