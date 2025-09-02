vim.api.nvim_create_autocmd("BufReadPost", { -- Set working directory to Neovim config directory when opening init.lua
  pattern = vim.env.HOME .. "/.config/nvim/init.lua",
  callback = function()
    vim.cmd("cd ~/.config/nvim")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight yanked text
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", { -- Navigate to last edit position in buffer upon entering
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", { -- Grapple: Tab and Shift-Tab to cycle scopes when in grapple buffer
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

vim.api.nvim_create_autocmd("BufLeave", { -- Remove grapple keymaps when leaving grapple buffer
  callback = function()
    local ft = vim.bo.filetype
    if ft == "grapple" then
      vim.keymap.del("n", "<tab>")
      vim.keymap.del("n", "<s-tab>")
    end
  end
})

vim.on_key( -- Auto toggle 'hlsearch' based on search commands
  function(char)
    if vim.fn.mode() == "n" then
      local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
      if vim.opt.hlsearch:get() ~= new_hlsearch then
        vim.opt.hlsearch = new_hlsearch
      end
    end
  end,
  vim.api.nvim_create_namespace("auto_hlsearch")
)


vim.api.nvim_create_autocmd("BufEnter", {  -- Set 'q' to close aerial-nav buffer
  callback = function()
    local ft = vim.bo.filetype
    if ft == "aerial-nav" then
      vim.keymap.set("n", "a", function()
        vim.cmd("AerialNavToggle")
        vim.schedule(function ()
          vim.cmd("AerialToggle")
        end)
      end)
      vim.keymap.set("n", "q", function()
        vim.cmd("AerialNavToggle")
      end)
    end
  end
})
