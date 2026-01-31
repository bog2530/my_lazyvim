-- plugins/blink.lua
return {
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100, -- Высокий приоритет для Copilot
                        async = true,
                        transform_items = function(_, items)
                            -- Ограничить количество предложений от Copilot для производительности
                            local max_items = 3
                            if #items > max_items then
                                local result = {}
                                for i = 1, max_items do
                                    table.insert(result, items[i])
                                end
                                return result
                            end
                            return items
                        end,
                    },
                },
            },
            appearance = {
                -- Использовать иконки из nerd font
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            keymap = {
                preset = "default",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide" },
                ["<C-y>"] = { "select_and_accept" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },
        },
    },
}
