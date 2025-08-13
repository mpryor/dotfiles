return {
    { -- Core debug adapter protocol plugin
        "mfussenegger/nvim-dap"
    },
    { -- Some autoconfiguration for Python
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup()
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
