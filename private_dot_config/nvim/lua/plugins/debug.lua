return {
    { -- Core debug adapter protocol plugin
        "mfussenegger/nvim-dap"
    },
    { -- Some autoconfiguration for Python
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup()
        end
    }
}
