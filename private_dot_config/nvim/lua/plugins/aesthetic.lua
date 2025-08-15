return {
    { 
        "nvim-tree/nvim-web-devicons",
        opts = {},
        config = function() 
            require("nvim-web-devicons").setup()
        end
    },
    { -- Colorscheme plugin
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require('tokyonight').setup {
                styles = {
                    comments = { italic = false },
                },
            }
            vim.cmd.colorscheme 'tokyonight-night'
        end,
    },
    { -- Integration with lualine to show code context from LSP
        'SmiteshP/nvim-navic',
        config = function()
            require('nvim-navic').setup({ lsp = { auto_attach = true } })
        end
    },
    { -- Statusline plugin
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('lualine').setup({
                sections = {
                    lualine_c = { 'filename', 'navic' },
                },
            })
        end,
    },
    { -- View marks in gutter
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
