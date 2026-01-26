return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- можно включить/выключить командой
  event = { "InsertLeave", "TextChanged" }, -- события для активации
  opts = {
    enabled = true, -- включен при запуске
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" }, -- сохранять сразу при выходе из файла
      defer_save = { "InsertLeave", "TextChanged" }, -- сохранять с задержкой при печати
    },
    debounce_delay = 1000, -- задержка в 1 секунду (чтобы не спамить сохранениями)
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      -- Не сохранять пустые буферы и специальные типы файлов
      if fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      return true
    end,
  },
}
