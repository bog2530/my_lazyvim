require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Настройки swap-файлов и производительности
vim.opt.swapfile = true  -- Включить swap-файлы (для безопасности)
vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"  -- Директория для swap
vim.opt.updatetime = 400  -- 400ms - оптимальный баланс между LSP/диагностикой и производительностью
-- Примечание: работает в связке с auto-save debounce (3000ms)

-- Настройки диагностики LSP
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many", -- Показывать источник если несколько LSP
    prefix = "●", -- Символ перед текстом
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- Не обновлять в Insert режиме
  severity_sort = true, -- Сортировать по важности
  float = {
    border = "rounded",
    source = "always", -- Всегда показывать источник (Ruff, basedpyright)
    header = "",
    prefix = "",
  },
})

-- Знаки для разных типов диагностики
local signs = { 
  Error = "󰅚 ", 
  Warn = "󰀪 ", 
  Hint = "󰌶 ", 
  Info = " " 
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
