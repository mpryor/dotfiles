return {
    'tpope/vim-vinegar',    -- NetRW enhancements (hit - in normal mode)
    'buztard/vim-rel-jump', -- Adds {count} motions to jumplist
    { -- New motions for quick navigation
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            jump = {
                history = true,
                register = true,
            },
            modes = {
                char = {
                    jump_labels = false
                },
                search = {
                    enabled = true
                }
            },
            continue = true
        },
    },
    { -- The ultimate "finder"/picker
        "nvim-telescope/telescope.nvim", -- see ../keymaps.lua
    },
    { -- File navigation with external program, Yazi
        "mikavilpas/yazi.nvim",
        version = "*",                   -- use the latest stable version
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            {
                "<leader>-",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
        },
    },
}
