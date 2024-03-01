-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep the cursor in the center of the screen when moving
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- System clipboard interactions
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking existing selection" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Remap increment to prevent clashing with tmux prefix command
vim.keymap.set({ "n", "v", "i" }, "<C-b>", "<C-a>", { desc = "Increment", silent = true })

-- Match escape key behaviour when exiting visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- I'm a compulsive saver
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Write file" })

-- I'm a compulsive quitter
vim.keymap.set("n", "<leader>z", ":wa<cr>:q<cr>", { desc = "Write all then quit" })

-- console.log
vim.keymap.set("n", "<leader>l", [["nyiwoconsole.log("<C-r>n", <C-r>n);<Esc>]], { desc = "Add console log on next line" })
vim.keymap.set("v", "<leader>l", [["nyoconsole.log("<C-r>n", <C-r>n);<Esc>]], { desc = "Add console log on next line" })
vim.keymap.set("n", "<leader>L", [["nyiwoconsole.log("<C-r>n", JSON.stringify(<C-r>n, null, 2));<Esc>]], { desc = "Add stringified console log on next line" })
vim.keymap.set("v", "<leader>L", [["nyoconsole.log("<C-r>n", JSON.stringify(<C-r>n, null, 2));<Esc>]], { desc = "Add stringified console log on next line" })
