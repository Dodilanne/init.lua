return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "princejoogie/dir-telescope.nvim", config = true },
    },
    config = function(_, opts)
      require("telescope").load_extension("dir")
    end,
    keys = {
      {
        "<leader>f",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Open file picker in root dir",
      },
      {
        "<leader>F",
        function()
          require("telescope").extensions.dir.find_files()
        end,
        desc = "Find file in specified dir",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Global search in workspace dir",
      },
      {
        "<leader>?",
        function()
          require("telescope").extensions.dir.live_grep()
        end,
        desc = "Global search in specified dir",
      },
      {
        "<leader>s",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Open symbol picker",
      },
      {
        "<leader>j",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Open jumplist picker",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Open buffer picker",
      },
      {
        "<leader>S",
        function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
        desc = "Open symbol picker",
      },
      {
        "<leader>d",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Open diagnostic picker",
      },
      {
        "<leader>D",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Open workspace diagnostic picker",
      },
    },
  },
}
