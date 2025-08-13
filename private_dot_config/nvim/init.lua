--" Mapleader needs to be set before plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap our plugin manager, lazy --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	require 'plugins',
	require 'lsp'
}, {
	change_detection = {
		notify = false,
	},
})

-- import local lua files --
require 'keymaps'
require 'options'
