return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      settings = {
        save_on_ui_close = true,
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup(opts)

      local harpoon_extensions = require("harpoon.extensions")
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

      vim.keymap.set("n", "<leader>hg", function()
        harpoon:list():add()
      end, { desc = "Add mark" })

      vim.keymap.set("n", "<leader>he", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Open quick menu" })

      local keys = { "a", "r", "s", "t", "z", "x", "c", "d", "v" }
      for idx, key in pairs(keys) do
        vim.keymap.set("n", "<leader>h" .. key, function()
          harpoon:list():select(idx)
        end, { desc = "Navigate to " .. idx })
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
