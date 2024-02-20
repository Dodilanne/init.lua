local theme = {
  dark = "kanagawa",
  light = "rose-pine",
}

local themes = {
  {
    name = "rose-pine",
    plugin = "rose-pine/neovim",
    opts = {
      styles = { italic = false },
    },
  },
  {
    name = "ayu",
    plugin = "Shatur/neovim-ayu",
    opts = {
      overrides = function()
        local colors = require("ayu.colors")
        colors.generate()
        return { LineNr = { fg = colors.comment } }
      end,
    },
  },
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

local function insert_current_theme(t)
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
end

for _, t in pairs(themes) do
  if t.name == theme.dark and os.getenv("NEOVIM_BACKGROUND") == "dark" then
    insert_current_theme(t)
  elseif t.name == theme.light and os.getenv("NEOVIM_BACKGROUND") == "light" then
    insert_current_theme(t)
  else
    table.insert(M, { t.plugin, lazy = true, name = t.name })
  end
end

return M
