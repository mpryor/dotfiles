return {
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
    { -- Statusline plugin
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('lualine').setup({
                sections = {
                    lualine_c = { 'filename' },
                },
            })
        end,
    },
    { -- Highlight code chunks
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    use_treesitter = true,
                    textobject = "ic",
                    delay = 0,
                    style="#ff9e64", -- nice orange to fit tokyonight theme
                },
                indent = {
                    enable = false,
                },
            })
        end
    },
    { -- View marks in gutter
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require('marks').setup()
        end
    },
    { -- Markdown preview
        "MeanderingProgrammer/render-markdown.nvim"
    },
    { -- Smear cursor
        "sphamba/smear-cursor.nvim",
        config = true
    }
}
