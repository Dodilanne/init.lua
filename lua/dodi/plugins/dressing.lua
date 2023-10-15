local say_hello = function()
  print("Hello from dressing.lua")
end
say_hello()

return {
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        insert_only = false,
        start_in_insert = false,
      },
    },
  },
}
