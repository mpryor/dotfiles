vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = vim.env.HOME .. "/.config/nvim/init.lua",
  callback = function()
    vim.cmd("cd ~/.config/nvim")
  end,
})
