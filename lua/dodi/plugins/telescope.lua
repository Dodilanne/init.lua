return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",

    dependencies = { "nvim-lua/plenary.nvim" },
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
          require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
        end,
        desc = "Open file picker in curr dir",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Global search in workspace folder",
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
      {
        "<leader>?",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Open command palette",
      },
    },
  },
}