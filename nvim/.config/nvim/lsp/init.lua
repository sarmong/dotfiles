local lsp_fns = require("lsp.functions")

lsp_fns.disable_virtual_text()
lsp_fns.enable_format_on_save()

require("lsp.servers")
require("lsp.cmp")
