return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                c = { "clang-format" },
                lua = { "stylua" },
                json = { "prettier_json" },
                jsonc = { "prettier_json" },
            },
            formatters = {
                prettier_json = {
                    command = "prettier",
                    args = { "--tab-width", "2", "--trailing-comma", "none", "--stdin-filepath", "$FILENAME" },
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>ii", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
