return {
    {
        "gbprod/yanky.nvim", -- Paste management
        config = function ()
            require("yanky").setup()
        end
    },
    {                         -- Focus mode
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
        config = function()
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
