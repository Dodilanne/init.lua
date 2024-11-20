local theme = {
  dark = "kanagawa",
  light = "bamboo",
}

local themes = {
  {
    name = "rose-pine",
    plugin = "rose-pine/neovim",
  },
  {
    name = "lackluster",
    colorscheme = "lackluster-hack",
    plugin = "slugbyte/lackluster.nvim",
    config = true,
  },
  {
    name = "srcery",
    plugin = "srcery-colors/srcery-vim",
  },
  {
    name = "bamboo",
    plugin = "ribru17/bamboo.nvim",
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

local M = {}

local function insert_current_theme(t)
  table.insert(M, {
    t.plugin,
    lazy = false,
    name = t.name,
    priority = 1001,
    config = function()
      local ok, plugin = pcall(require, t.name)
      if ok then
        plugin.setup(t.opts or {})
      end
      vim.cmd("colorscheme " .. (t.colorscheme or t.name))
    end,
  })
end

for _, t in pairs(themes) do
  local preset = os.getenv("NEOVIM_BACKGROUND") or "dark"
  if t.name == theme.dark and preset == "dark" then
    insert_current_theme(t)
  elseif t.name == theme.light and preset == "light" then
    insert_current_theme(t)
  else
    table.insert(M, { t.plugin, lazy = true, name = t.name })
  end
end

return M
