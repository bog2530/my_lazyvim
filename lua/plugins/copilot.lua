-- plugins/copilot.lua
return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = false, -- Отключаем inline suggestions, используем через blink.cmp
            },
            panel = {
                enabled = false, -- Отключаем панель, используем через blink.cmp
            },
            filetypes = {
                -- Основные языки программирования
                python = true,
                go = true,
                lua = true,
                javascript = true,
                typescript = true,
                
                -- Конфиг/данные
                json = true,
                yaml = true,
                toml = true,
                
                -- Документация
                markdown = true,
                
                -- Отключить остальное
                help = false,
                gitcommit = false,
                gitrebase = false,
                ["."] = false,
            },
        },
    },
    {
        "giuxtaposition/blink-cmp-copilot",
        dependencies = { "zbirenbaum/copilot.lua" },
    },
}
