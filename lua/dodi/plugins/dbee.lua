return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install("go")
    end,
    config = function()
      require("dbee").setup({
        sources = {
          require("dbee.sources").FileSource:new(vim.fn.stdpath("config") .. "/.env.dbee.json"),
        },
      })
    end,
    keys = {
      { "<leader>B", "<cmd>Dbee<cr>", desc = "Open DB client" },
    },
  },
}
