return {
    { -- Like vinegar
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({})
        end
    },
    { -- Persistent bookmarks, scoped by directory, repo, branch, etc
        "cbochs/grapple.nvim",
        opts = {
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>m", "<cmd>Grapple toggle<cr>",          desc = "Grapple toggle tag" },
            { "';",        "<cmd>Grapple toggle_tags<cr>",     desc = "Grapple open tags window" },
            { "]]",        "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
            { "[[",        "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
        },
        config = function()
            require('grapple').setup({
                scope = "cwd",
                default_scopes = {
                    lsp = { hidden = true },
                    git_branch = { hidden = true },
                    static = { hidden = true },
                    git = { hidden = true },
                },
            })
        end
    },
    'buztard/vim-rel-jump',  -- Adds {count} motions to jumplist
    {                        -- New motions for quick navigation
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            jump = {
                nohlsearch = true,
                history = true,
                register = true,
            },
            modes = {
                char = {
                    jump_labels = true
                },
                search = {
                    enabled = true,
                }
            },
            continue = true
        },
    },
    {                                    -- The ultimate "finder"/picker
        "nvim-telescope/telescope.nvim", -- see ../keymaps.lua
        config = function()
            local actions = require("telescope.actions")
            local telescope = require("telescope")
            local telecope_builtin = require("telescope.builtin")
            local telescope_extensions = require('telescope').extensions

            -- Allows cycling between various pickers
            local cycle = require("cycle")(telecope_builtin.find_files, telescope_extensions.smart_open.smart_open)

            local function flash(prompt_bufnr)
                require("flash").jump({
                    pattern = "^",
                    label = { after = { 0, 0 } },
                    search = {
                        mode = "search",
                        exclude = {
                            function(win)
                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                            end,
                        },
                    },
                    action = function(match)
                        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        picker:set_selection(match.pos[1] - 1)
                    end,
                })
            end

            telescope.setup({
                defaults = {
                    -- Set "ivy" as default theme
                    layout_strategy = 'bottom_pane',
                    layout_config = {
                        height = 0.6,
                    },
                    border = true,
                    sorting_strategy = "ascending",
                    --
                    mappings = {
                        i = {
                            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                            ["<tab>"] = cycle.next,
                            ["<s-tab>"] = cycle.previous,
                            ["<leader><leader>"] = flash,
                        },
                        n = {
                            ["s"] = flash
                        }
                    }
                },
                pickers = {
                    buffers = {
                        mappings = {
                            n = {
                                ["dd"] = actions.delete_buffer
                            }
                        }
                    }
                }
            })
        end
    },
    {
        "danielfalk/smart-open.nvim", -- A smarter file picker
        branch = "0.2.x",
        config = function()
            local telescope = require("telescope")
            smart_open_extension = telescope.load_extension("smart_open")
            telescope.setup({
                extensions = {
                    smart_open = {
                        show_scores = true,
                        match_algorithm = "fzf",
                        disable_devicons = true,
                    }
                }
            })
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },
}
