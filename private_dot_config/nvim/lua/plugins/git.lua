return {
    {
    { -- The classic - manage everything Git while in vim
        "tpope/vim-fugitive"
    },
    { "lewis6991/gitsigns.nvim" }, -- Show git information in the sign column (and more)
    { -- Open merge conflict files with vim - easy resolution and hunk jumping
        "akinsho/git-conflict.nvim",
        lazy = false,
        --tag = "v2.1.0",
        commit = "4bbfdd9",
        --version = "v2.1.0",
        config = function()
            require("git-conflict").setup {
                -- Your existing git-conflict config
                default_mappings = true,
                disable_diagnostics = false,
                debug = true,
                -- Add this to your highlights if you want
                highlights = {
                    incoming = "DiffText",
                    current = "DiffAdd",
                },
            }
        end,
        dependencies = { "yorickpeterse/nvim-pqf" },
    },
}
