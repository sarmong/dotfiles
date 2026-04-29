local contrib = req("plugins.ide.contrib")

contrib.mason("pyright", "black", "ruff")

contrib.formatters("python", { "ruff_format" })
contrib.ts_parsers("python")
contrib.lsp({ "pyright", "ruff" })
