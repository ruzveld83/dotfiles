return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Debug continue" })
            vim.keymap.set("n", "<F7>", "<cmd>DapStepInto<CR>", { desc = "Debug step into" })
            vim.keymap.set("n", "<F8>", "<cmd>DapStepOver<CR>", { desc = "Debug step over" })
            vim.keymap.set("n", "<F9>", "<cmd>DapStepOut<CR>", { desc = "Debug step out" })
            vim.keymap.set("n", "<leader>dq", "<cmd>DapTerminate<CR>", { desc = "Detach debugger" })
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim", -- mason setup shauld be called before mason-nvim-dap setup
        },
        config = function()
            require("mason-nvim-dap").setup({
                handlers = {},
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            -- the following is for automatic opening and closing of ui windows
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
        end,
    },
}
