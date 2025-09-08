return {
    { "rcarriga/nvim-notify" }, -- simple notifications
    {                         -- simple, automatic session management
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
                        local shada_file_name = vim.fn.stdpath("data") .. "/shadas/" .. cwd_hash .. '.shada'
                        vim.cmd('wshada! ' .. shada_file_name:gsub('%%', '\\%%'))
                    end,
                },
                -- load shada when loading session - Why is this not default behavior??
                post_restore_cmds = {
                    function()
                        local autosession = require('auto-session')
                        local cwd_hash = vim.fn.sha256(vim.fn.getcwd())
                        local shada_file_name = vim.fn.stdpath("data") .. "/shadas/" .. cwd_hash .. '.shada'
                        if vim.fn.filereadable(shada_file_name) == 1 then
                            vim.cmd('rshada! ' ..
                                shada_file_name:gsub('%%', '\\%%'))
                        end
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
        "akinsho/toggleterm.nvim", -- Terminal integration
        config = function()
            require("toggleterm").setup({
                open_mapping = "<leader>\\",
                start_in_insert = true,
                persist_mode = false,
                insert_mappings = false,
                direction = 'vertical',
                size = function()
                    return vim.o.columns * .4
                end
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
    { "mbbill/undotree" },                         -- A nice way to explore the undo tree
    {                                              -- Highlight, edit, and navigate code
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
                        ["am"] = "@function.outer",
                        ["im"] = "@function.inner",
                        ["is"] = "@block.inner", -- pneumonic: inner scope
                        ["as"] = "@block.outer", -- pneumonic: around scope
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = 'V',     -- linewise
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]s"] = "@block.inner",
                        ["]S"] = "@block.outer",
                        ["]M"] = "@function.inner",
                        ["]m"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[s"] = "@block.inner",
                        ["[S"] = "@block.outer",
                        ["[M"] = "@function.inner",
                        ["[m"] = "@function.outer",
                    },
                }
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = "<bs>",
                },
            },
            indent = { enable = true },
        },
    },
}
-- vim: ts=4 sw=4 et
