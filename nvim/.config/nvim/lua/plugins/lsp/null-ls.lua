local null_ls = require("null-ls")
local lsp_fns = require("plugins.lsp.functions")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			lsp_fns.enable_format_on_save()
		end
	end,
})
