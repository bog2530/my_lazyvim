require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",

  -- Python
  "basedpyright",
  "ruff",

  -- Go
  "gopls",
}

vim.lsp.enable(servers)


vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly", -- Быстрее, только открытые файлы
      },
    },
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {
      args = {},
    },
  },
  -- Настройка capabilities и on_attach для Ruff
  on_attach = function(client, bufnr)
    -- Отключить hover и форматирование у Ruff (используем basedpyright и conform)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.documentFormattingProvider = false
    
    -- Добавить команду для организации импортов
    vim.api.nvim_buf_create_user_command(bufnr, "RuffOrganizeImports", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
      })
    end, { desc = "Ruff: Organize Imports" })
    
    -- Добавить команду для применения всех автофиксов
    vim.api.nvim_buf_create_user_command(bufnr, "RuffAutofix", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.fixAll" },
          diagnostics = {},
        },
      })
    end, { desc = "Ruff: Fix All Auto-fixable Problems" })
  end,
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true, -- Более строгое форматирование
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})


-- read :h vim.lsp.config for changing options of lsp servers 
