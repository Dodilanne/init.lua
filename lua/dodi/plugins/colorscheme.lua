local theme = {
  dark = "kanso",
  light = "kanso",
}

local themes = {
  {
    name = "kanso",
    plugin = "webhooked/kanso.nvim",
    opts = {
      theme = "zen",
      background = {
        dark = "zen",
        light = "pearl",
      },
    },
  },
  {
    name = "rose-pine",
    plugin = "rose-pine/neovim",
  },
  {
    name = "catppuccin",
    plugin = "catppuccin/nvim",
  },
  {
    name = "lackluster",
    colorscheme = "lackluster-hack",
    plugin = "slugbyte/lackluster.nvim",
    opts = {},
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

local M = {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd("colorscheme " .. theme.dark)
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.cmd("colorscheme " .. theme.light)
        vim.api.nvim_set_option_value("background", "light", {})
      end,
    },
  },
}

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

local preset = os.getenv("NEOVIM_BACKGROUND") or "dark"
-- local handle = io.popen("dark-mode status", "r")
-- if handle then
--   local status = handle:read("*l")
--   if status == "off" then
--     preset = "light"
--   end
--   handle:close()
-- end

for _, t in pairs(themes) do
  if t.name == theme.dark and preset == "dark" then
    insert_current_theme(t)
  elseif t.name == theme.light and preset == "light" then
    insert_current_theme(t)
  else
    table.insert(M, { t.plugin, lazy = true, name = t.name, opts = t.opts })
  end
end

return M
