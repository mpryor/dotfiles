vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = vim.env.HOME .. "/.config/nvim/init.lua",
  callback = function()
    vim.cmd("cd ~/.config/nvim")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local ft = vim.bo.filetype
    if ft == "grapple" then
      local grapple = require("grapple")
      vim.keymap.set("n", "<tab>", function()
        grapple.cycle_scopes("next")
        grapple.open_tags()
      end)
      vim.keymap.set("n", "<s-tab>", function()
        grapple.cycle_scopes("prev")
        grapple.open_tags()
      end)
    end
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    local ft = vim.bo.filetype
    if ft == "grapple" then
      vim.keymap.del("n", "<tab>")
      vim.keymap.del("n", "<s-tab>")
    end
  end
})

vim.on_key(
  function(char)
    if vim.fn.mode() == "n" then
      local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/", "z", "v" }, vim.fn.keytrans(char))
      if vim.opt.hlsearch:get() ~= new_hlsearch then
        vim.opt.hlsearch = new_hlsearch
      end
    end
  end,
  vim.api.nvim_create_namespace("auto_hlsearch")
)
