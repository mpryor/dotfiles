return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'python' },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["is"] = "@block.inner",
                        ["as"] = "@block.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = 'V', -- linewise
                    },
                    include_surrounding_whitespace = false,
                },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = "<C-space>",
                    node_decremental = "<bs>",
                },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },
}
-- vim: ts=4 sw=4 et
