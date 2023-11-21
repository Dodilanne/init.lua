local theme = "kanagawa"
local themes = {
  { name = "rose-pine", plugin = "rose-pine/neovim", opts = { disable_italics = true } },
  { name = "ayu", plugin = "Shatur/neovim-ayu" },
  {
    name = "kanagawa",
    plugin = "rebelot/kanagawa.nvim",
    opts = {
      background = { dark = "dragon", light = "lotus" },
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    },
  },
}

local M = {
  {
    "f-person/auto-dark-mode.nvim",
    priority = 1000,
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

for _, t in pairs(themes) do
  if t.name == theme then
    table.insert(M, {
      t.plugin,
      lazy = false,
      name = t.name,
      priority = 1001,
      config = function()
        require(t.name).setup(t.opts or {})
        vim.cmd("colorscheme " .. t.name)
      end,
    })
  else
    table.insert(M, { t.plugin, lazy = true, name = t.name })
  end
end

return M
