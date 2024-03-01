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
          accept_line = "<m-e>",
          accept_word = "<m-i>",
          dismiss = "<m-o>",
        },
      },
    },
  },
}
