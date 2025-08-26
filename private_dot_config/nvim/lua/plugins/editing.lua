return {
    { "tpope/vim-surround" }, -- Simple motions to surround textObjects
    {
        "gbprod/yanky.nvim",  -- Paste management
        config = function()
            require("yanky").setup()
        end
    },
    { -- Focus mode
        "folke/zen-mode.nvim",
    },
    {
        "windwp/nvim-autopairs", -- Autopairs support
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
    { -- Basic comment motion support
        'numToStr/Comment.nvim',
    },
    { -- Discover tabstops, shiftwidth, and expandtab from file
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    { -- Completion plugin with LSP support
        'saghen/blink.cmp',
        dependencies = { { 'L3MON4D3/LuaSnip', version = 'v2.*' }, 'folke/lazydev.nvim' },
        version = '1.*',
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap
            snippets = { preset = 'luasnip' },
            signature = { enabled = true },
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },
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
