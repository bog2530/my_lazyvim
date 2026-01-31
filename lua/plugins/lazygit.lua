-- plugins/lazygit.lua
return {
    -- Toggleterm для терминалов
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
            },
        },
    },
    
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>",            desc = "LazyGit" },
            { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
        },
    },
    {
        "mgierada/lazydocker.nvim",
        cmd = { "LazyDocker" },
        dependencies = {
            "akinsho/toggleterm.nvim",
        },
        keys = {
            { "<leader>ld", "<cmd>LazyDocker<cr>", desc = "LazyDocker" },
        },
        opts = {},
    },
}
