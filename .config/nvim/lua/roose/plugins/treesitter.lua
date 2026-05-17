return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "java",
                "javascript",
                "typescript",
                "scala",
                "python",
            },
            sync_install = false,
            auto_install = false,
        })

        -- Disable treesitter highlighting for large files (>100 KB)
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_large_file", { clear = true }),
            callback = function(args)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                if ok and stats and stats.size > max_filesize then
                    vim.treesitter.stop(args.buf)
                end
            end,
        })
    end,
}
