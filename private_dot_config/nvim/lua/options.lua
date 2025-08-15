vim.o.relativenumber = true
vim.o.number = true
vim.o.hidden = true
vim.o.updatetime = 1000 -- How long it takes to highlight matching variables under cursor
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.list = true
vim.o.undofile = true
vim.o.cursorline = true

-- Customize debugging colors and icons
vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.cmd("hi DapStoppedColor guifg=#00FF00")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedColor", linehl = "", numhl = "DapStoppedColor" })
