vim.opt.background = os.getenv("NEOVIM_BACKGROUND") or "dark"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.guicursor = ""

vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.matchpairs:append("<:>")

vim.g.firenvim_config = {
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			takeover = "never",
		},
	},
}
