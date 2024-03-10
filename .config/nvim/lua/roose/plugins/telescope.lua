return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function() require("telescope").load_extension("fzf") end,
            },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", {})
            vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", {})
            vim.keymap.set("n", "<leader>fr", "<CMD>Telescope live_oldfiles<CR>", {})
            vim.keymap.set("n", "<leader>km", "<CMD>Telescope keymaps<CR>", {})
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
            })
        end,
    },
}
