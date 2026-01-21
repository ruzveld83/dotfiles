return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
                component_separators = '|',
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch' },
                lualine_c = { 'diagnostics' },
                lualine_x = {
                    { 'searchcount' },
                    { 'selectioncount' },
                    {
                        'lsp_status',
                        icon = '',
                        show_name = true,
                    }
                },
                lualine_y = { 'filetype', 'progress' },
                lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
            },
        })
    end,
}
