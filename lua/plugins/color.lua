return {
  -- 1. Добавляем тему Ayu
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    opts = {
      overrides = {},
    },
    config = function(_, opts)
      require("ayu").setup(opts)
      -- Устанавливаем Ayu при старте
      vim.cmd("colorscheme ayu-mirage")
    end,
  },

  -- 2. Добавляем Kanagawa (будет доступна в списке через <leader>uC)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      transparent = false,
      theme = "wave",
    },
  },

  -- 3. Настройка LazyVim (указываем основную тему)
  {
    "LazyVim/LazyVim",
    opts = {
      -- Это гарантирует, что LazyVim подстроит свои компоненты (lualine и т.д.) под Ayu
      colorscheme = "ayu-mirage",
    },
  },
}
