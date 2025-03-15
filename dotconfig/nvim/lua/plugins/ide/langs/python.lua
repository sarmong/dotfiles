local contrib = req("plugins.ide.contrib")

contrib.mason("python-lsp-server", "pyright", "black")

contrib.formatters("python", "black") -- @TODO ruff?
contrib.ts_parsers("python")
contrib.lsp({ "pylsp", "pyright" })
