local theme = {
  dark = "kanagawa",
  light = "rose-pine",
}

local themes = {
  {
    name = "rose-pine",
    plugin = "rose-pine/neovim",
    opts = {
      styles = {
        transparency = true
      }
    }
  },
  {
    name = "kanagawa",
    plugin = "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      background = { dark = "wave", light = "lotus" },
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
