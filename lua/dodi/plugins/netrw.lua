local function toggle_netrw()
  if vim.bo.filetype == "netrw" then
    vim.cmd("Rex")
  else
    vim.cmd("Ex")
  end
end

vim.keymap.set({ "n", "v" }, "<leader>e", toggle_netrw, { desc = "Open Netrw", silent = true })

return {}
