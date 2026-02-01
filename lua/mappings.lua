require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Ctrl+C в терминале: отправить сигнал прерывания, затем закрыть терминал и удалить буфер
map("t", "<C-a>", function()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()

  -- Отправить Ctrl+C процессу в терминале (сигнал SIGINT)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-a>", true, false, true), "n", true)

  -- Задержка для завершения процесса
  vim.defer_fn(function()
    -- Закрыть окно если оно еще существует
    if vim.api.nvim_win_is_valid(win) then
      pcall(vim.api.nvim_win_close, win, true)
    end

    -- Удалить буфер терминала принудительно
    if vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.cmd, "bdelete! " .. buf)
    end
  end, 150) -- Задержка 150ms
end, { desc = "Kill terminal process and close" })

-- Ctrl+X в normal mode терминала: закрыть окно терминала (спрятать)
map("n", "<C-x>", function()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

  -- Проверяем, что мы в терминальном буфере
  if filetype:match "^NvTerm_" then
    pcall(vim.api.nvim_win_close, win, true)
  end
end, { desc = "Close terminal window (hide)" })

-- Ctrl+A в normal mode терминала: убить процесс и закрыть
map("n", "<C-a>", function()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

  -- Проверяем, что мы в терминальном буфере
  if filetype:match "^NvTerm_" then
    -- Получить job_id терминала и отправить Ctrl+A
    local job_id = vim.b[buf].terminal_job_id
    if job_id then
      vim.api.nvim_chan_send(job_id, "\x01") -- Ctrl+A = ASCII 0x01
    end

    -- Задержка для завершения процесса
    vim.defer_fn(function()
      -- Закрыть окно если оно еще существует
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_close, win, true)
      end

      -- Удалить буфер терминала принудительно
      if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.cmd, "bdelete! " .. buf)
      end
    end, 150)
  end
end, { desc = "Kill terminal process and close (normal mode)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>i", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating term" })

-- LSP маппинги
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "LSP show line diagnostics" })
map("n", "<leader>co", function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  }
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

map("v", ">", ">gv", { desc = "Сдвиг вправо без потери выделения" })
map("v", "<", "<gv", { desc = "Сдвиг влево без потери выделения" })
