return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
    config = function(_, opts)
      vim.opt.showmode = false
      require("lualine").setup(opts)
    end,
  },
}
