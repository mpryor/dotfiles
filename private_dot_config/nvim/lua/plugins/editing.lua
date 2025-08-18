return {
    { -- Focus mode
        "folke/zen-mode.nvim",
    },
    { -- Basic comment motion support
        'numToStr/Comment.nvim',
    },
    { -- Discover tabstops, shiftwidth, and expandtab from file
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    },
    {
        "ThePrimeagen/harpoon",
        commit = "bfd649328a7effe4b7c311d39e97059d31144632",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({
                settings = {
                    key = function()
                        return "global" -- All lists anywhere will be shared globally
                    end,
                },
                default = {
                    get_root_dir = function()
                        return "global"
                    end
                }
            })
            local map = vim.keymap.set
            vim.g.last_harpoon_list = 0

            -- Helper function to build list name from digit
            local function list_name(num)
                return "list_" .. num
            end

            -- Toggle Harpoon quick menu for list i
            map("n", string.format("';", i), function()
                harpoon.ui:toggle_quick_menu(harpoon:list(list_name(vim.g.last_harpoon_list)))
            end, { desc = "Harpoon quick menu for list "})

            -- Navigate to next item in list i
            map("n", string.format("]]", i), function()
                harpoon:list(list_name(vim.g.last_harpoon_list)):next()
            end, { desc = "Harpoon next in list "})

            -- Navigate to prev item in list i
            map("n", string.format("[[", i), function()
                harpoon:list(list_name(vim.g.last_harpoon_list)):prev()
            end, { desc = "Harpoon prev in list "})

            -- Create functions for each list (0-9)
            for i = 0, 9 do
                -- Add current file to list i
                map("n", string.format("m%d", i), function()
                    harpoon:list(list_name(i)):add()
                end, { desc = "Harpoon add file to list " .. i })

                -- Toggle Harpoon quick menu for list i
                map("n", string.format("'%d", i), function()
                    vim.g.last_harpoon_list = i
                    harpoon.ui:toggle_quick_menu(harpoon:list(list_name(i)))
                end, { desc = "Harpoon quick menu for list " .. i })


                -- Navigate to next item in list i
                map("n", string.format("]%d", i), function()
                    harpoon:list(list_name(i)):next()
                end, { desc = "Harpoon next in list " .. i })

                -- Navigate to prev item in list i
                map("n", string.format("[%d", i), function()
                    harpoon:list(list_name(i)):prev()
                end, { desc = "Harpoon prev in list " .. i })
            end
        end
    },
    { -- Completion plugin with LSP support
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', 'folke/lazydev.nvim' },
        version = '1.*',
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap
            signature = { enabled = true },
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    }
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
