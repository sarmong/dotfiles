local contrib = req("plugins.ide.contrib")

contrib.mason({ "cssls", "cssmodules_ls", "prettierd", "prettier" })

contrib.formatters({ "css", "scss", "less" }, { "prettierd", "prettier" })
contrib.ts_parsers({ "css", "scss" })
contrib.lsp({ "cssls", "cssmodules_ls", "tailwindcss" })

contrib.ts_parsers("html")
contrib.formatters("html", { "prettierd", "prettier" })
