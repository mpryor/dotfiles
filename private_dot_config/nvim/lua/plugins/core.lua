return {
    { -- simple, automatic session management
        "rmagatti/auto-session",
        lazy = false,
        opts = {
        },
        config = function()
            require("auto-session").setup({
                -- save shada when we save a session - Why is this not default behavior??
                post_save_cmds = {
                    function()
                        local autosession = require('auto-session')
                        local cwd_hash = vim.fn.sha256(vim.fn.getcwd())
                        local shada_file_name = autosession.get_root_dir() .. cwd_hash .. '.shada'
                        vim.cmd('wshada! ' .. shada_file_name:gsub('%%', '\\%%'))
                    end,
                },
                -- load shada when loading session - Why is this not default behavior??
                post_restore_cmds = {
                    function()
                        local autosession = require('auto-session')
                        local cwd_hash = vim.fn.sha256(vim.fn.getcwd())
                        local shada_file_name = autosession.get_root_dir() .. cwd_hash .. '.shada'
                        if vim.fn.filereadable(shada_file_name) == 1 then vim.cmd('rshada! ' ..
                            shada_file_name:gsub('%%', '\\%%')) end
                    end,
                },
                session_lens = {
                    mappings = {
                        delete_session = { "n", "dd" }
                    }
                }
            })
        end
    },
    {
        "akinsho/toggleterm.nvim", config=function()
            require("toggleterm").setup({
                open_mapping = "<leader>\\"
            })
        end
    },
    { -- LSP integration for lazy config
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { -- Like vinegar
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({})
        end
    },
    {                      -- Highlight, edit, and navigate code
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
