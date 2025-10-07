return {
    { -- Core debug adapter protocol plugin,
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.bashdb = {
                type = 'executable',
                command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
                name = 'bashdb',
            }
            dap.configurations.sh = {
                {
                    type = 'bashdb',
                    request = 'launch',
                    name = "Launch file",
                    showDebugOutput = true,
                    pathBashdb = vim.fn.stdpath("data") ..
                    '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
                    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
                    trace = true,
                    file = "${file}",
                    program = "${file}",
                    cwd = '${workspaceFolder}',
                    pathCat = "cat",
                    pathBash = "/opt/homebrew/bin/bash",
                    pathMkfifo = "mkfifo",
                    pathPkill = "pkill",
                    args = {},
                    argsString = '',
                    env = {},
                    terminalKind = "integrated",
                }
            }
        end
    },
    { -- Some autoconfiguration for Python
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup()
            local dap = require('dap')
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    justMyCode = false,
                    env = {
                        PYTHONPATH = vim.fn.getcwd()
                    }
                },
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies =
        {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            require("dapui").setup()
        end
    }
}
