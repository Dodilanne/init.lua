return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<m-j>",
          accept_line = "<m-k>",
          accept_word = "<m-l>",
          dismiss = "<m-;>",
        },
      },
    },
  },
}
