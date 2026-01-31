return {
    {
        "stevearc/conform.nvim",
        event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    -- Переопределяем настройки treesitter (не весь плагин!)
    {
      "nvim-treesitter/nvim-treesitter",
      opts = require "configs.treesitter",
    },

    -- Auto-save plugin
    {
        "okuuva/auto-save.nvim",
        event = { "InsertLeave", "TextChanged" },
        opts = {
            enabled = true,
            trigger_events = {
                immediate_save = { "BufLeave", "FocusLost" },
                defer_save = { "InsertLeave", "TextChanged" },
                cancel_deferred_save = { "InsertEnter" },
            },
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                -- Сохранять только изменяемые файлы с именем
                if fn.getbufvar(buf, "&modifiable") == 1
                    and fn.getbufvar(buf, "&buftype") == ""
                    and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                    return true
                end
                return false
            end,
            write_all_buffers = false,
            debounce_delay = 3000, -- 3 секунды - оптимальный баланс (работает с updatetime 400ms)
        },
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy", -- Отложенная загрузка для ускорения старта
        opts = {},
    },

    -- Красивые уведомления (как в LazyVim)
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            render = "compact",           -- compact, minimal, simple, default
            stages = "fade_in_slide_out", -- fade, slide, fade_in_slide_out, static
            top_down = true,
        },
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },

    -- Улучшенный UI: командная строка, окна поиска, уведомления (как в LazyVim)
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    enabled = true,
                    silent = false,
                },
                signature = {
                    enabled = false, -- Отключаем автоматический signature help (мешает печати)
                },
            },
            presets = {
                bottom_search = true,         -- Поиск внизу как в LazyVim
                command_palette = true,       -- Командная палитра в центре (красивее и быстрее)
                long_message_to_split = true, -- Длинные сообщения в сплите
                inc_rename = false,           -- Отключаем, используем стандартный rename
                lsp_doc_border = true,        -- Рамки для LSP документации
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                            { find = "written" }, -- "file.txt written"
                        },
                    },
                    opts = { skip = true },
                },
            },
        },
    },
}
