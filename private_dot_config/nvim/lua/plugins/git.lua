return {
    {
        "tpope/vim-fugitive"
    },
    { -- Integration with external program, lazygit
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    { -- A potentially useful tool for resolving conflicts... might delete
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
