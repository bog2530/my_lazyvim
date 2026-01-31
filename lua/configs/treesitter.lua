pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

-- Настройка компилятора для Windows
if vim.fn.has("win32") == 1 then
  -- Это сработает когда модуль загрузится
  local ok, install = pcall(require, "nvim-treesitter.install")
  if ok then
    install.compilers = { "gcc" }
    install.prefer_git = false
  end
end

return {
  ensure_installed = {
    "lua", "luadoc", "printf", "vim", "vimdoc",
    "html", "css",
    "python", "rst", "toml",
    "go", "gomod", "gosum", "gowork",
    "json", "jsonc", "yaml",
    "markdown", "markdown_inline",
    "rust",
  },
  
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  
  indent = { enable = true },
}
