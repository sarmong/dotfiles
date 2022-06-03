local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({ automatic_installation = true })

require("lsp.servers.ts")
require("lsp.servers.lua")
require("lsp.servers.css")
require("lsp.servers.bash")
require("lsp.servers.viml")
-- require("lsp.servers.remark")

require("lsp.servers.null-ls")
