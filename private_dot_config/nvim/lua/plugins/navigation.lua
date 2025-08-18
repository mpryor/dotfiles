return {
    'tpope/vim-vinegar',    -- NetRW enhancements (hit - in normal mode)
    'buztard/vim-rel-jump', -- Adds {count} motions to jumplist
    {                       -- New motions for quick navigation
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
    { -- A better "recent files"
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            -- Only required if using match_algorithm fzf
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    },
    {                                    -- The ultimate "finder"/picker
        "nvim-telescope/telescope.nvim", -- see ../keymaps.lua
    },
    {                  -- File navigation with external program, Yazi
        "mikavilpas/yazi.nvim",
        version = "*", -- use the latest stable version
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
