require "nvchad.autocmds"

-- Не показывать предупреждение о существующем swap-файле
vim.opt.shortmess:append("A")

-- Автооткрытие nvim-tree при старте (вместе с dashboard)
local autocmd = vim.api.nvim_create_autocmd

-- Открыть дерево когда dashboard полностью загружен
-- autocmd("FileType", {
--   pattern = "nvdash",
--   callback = function()
--     vim.defer_fn(function()
--       -- Проверить что nvim-tree еще не открыт
--       local tree_exists = false
--       for _, win in ipairs(vim.api.nvim_list_wins()) do
--         local buf = vim.api.nvim_win_get_buf(win)
--         local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
--         if ft == "NvimTree" then
--           tree_exists = true
--           break
--         end
--       end
--
--       if not tree_exists then
--         -- Открыть nvim-tree
--         require("nvim-tree.api").tree.open()
--         -- Вернуть фокус на dashboard
--         vim.defer_fn(function()
--           for _, win in ipairs(vim.api.nvim_list_wins()) do
--             local buf = vim.api.nvim_win_get_buf(win)
--             local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
--             if ft == "nvdash" then
--               vim.api.nvim_set_current_win(win)
--               break
--             end
--           end
--         end, 10)
--       end
--     end, 10)
--   end,
--   once = true, -- Запустить только один раз
-- })
