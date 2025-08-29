return {
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<S-tab>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
        },
        config = function()
            require("CopilotChat").setup({
                window = {
                    layout = 'vertical',
                    title = '🤖 AI Assistant',
                    zindex = 100, -- Ensure window stays on top
                },
                headers = {
                    user = '👤 You',
                    assistant = '🤖 Copilot',
                    tool = '🔧 Tool',
                },
                separator = '━━',
                auto_fold = true, -- Automatically folds non-assistant messages
            })
            -- Auto-command to customize chat buffer behavior
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = 'copilot-*',
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                    vim.opt_local.conceallevel = 0
                    vim.cmd('Copilot disable')
                end,
            })

            vim.api.nvim_create_autocmd('BufLeave', {
                pattern = 'copilot-*',
                callback = function()
                    vim.cmd('Copilot enable')
                end,
            })
        end
    },
}
