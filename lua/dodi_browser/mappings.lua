vim.keymap.set("n", "<A-d>", "Vyp")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

-- Match escape key behaviour when exiting visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>w", ":wq<CR>", { desc = "Save and quit", silent = true })

-- Remap increment to prevent clashing with tmux prefix command
vim.keymap.set({ "n", "v", "i" }, "<C-b>", "<C-a>", { desc = "Increment", silent = true })
