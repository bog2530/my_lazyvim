require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Универсальное двойное ESC для закрытия окон
map("n", "<Esc><Esc>", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()

    -- Попробовать закрыть текущее окно если это floating, terminal или специальный буфер
    local win_config = vim.api.nvim_win_get_config(current_win)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = current_buf })
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

    -- Если текущее окно floating - закрыть его
    if win_config.relative ~= "" then
        pcall(vim.api.nvim_win_close, current_win, true)
        return
    end

    -- Если в специальном буфере (терминал, nvim-tree, и т.д.) - закрыть окно
    if buftype ~= "" or filetype == "NvimTree" or filetype == "nvdash" then
        -- Проверить количество окон, не закрывать последнее
        if #vim.api.nvim_list_wins() > 1 then
            vim.cmd("close")
        end
        return
    end

    -- Закрыть все остальные floating окна
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if win ~= current_win and vim.api.nvim_win_is_valid(win) then
            local success, config = pcall(vim.api.nvim_win_get_config, win)
            if success and config.relative ~= "" then
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_type = vim.api.nvim_get_option_value("buftype", { buf = buf })

                -- Закрывать все floating окна кроме терминалов
                if buf_type ~= "terminal" then
                    pcall(vim.api.nvim_win_close, win, true)
                end
            end
        end
    end

    -- Очистить подсветку поиска
    vim.cmd("nohlsearch")
end, { desc = "Close current/floating windows and clear search" })

-- Выход из терминала в Normal mode (без закрытия)
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>i", function() require("nvchad.term").toggle({ pos = "float", id = "floatTerm" }) end,
    { desc = "Toggle floating term" })

-- LSP маппинги
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "LSP show line diagnostics" })
map("n", "<leader>co", function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.organizeImports" },
            diagnostics = {},
        },
    })
end, { desc = "LSP organize imports" })

-- Навигация по диагностике
map("n", "]d", vim.diagnostic.goto_next, { desc = "LSP goto next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP goto prev diagnostic" })
map("n", "<leader>q", "<cmd>Telescope diagnostics<CR>", { desc = "LSP diagnostics (Telescope)" })

-- LSP навигация
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP goto definition" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP goto references" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP goto declaration" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover info" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })

-- Signature help (вызывать вручную когда нужно)
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
