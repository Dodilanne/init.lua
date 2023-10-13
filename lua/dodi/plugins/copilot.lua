return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<m-n>",
          accept_line = "<m-l>",
          accept_word = "<m-h>",
          dismiss = "<m-o>",
        },
      },
    },
  },
}
