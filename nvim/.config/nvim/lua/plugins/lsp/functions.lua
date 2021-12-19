local fns = {}

fns.format = function()
	local clients = vim.lsp.buf_get_clients(0)
	if #clients > 1 then
		-- check if multiple clients, and if null-ls is setup
		for _, c1 in pairs(clients) do
			if c1.name == "null-ls" then
				-- if null-ls then disable others
				for _, c2 in pairs(clients) do
					-- print(c2.name, c2.resolved_capabilities.document_formatting)
					if c2.name ~= "null-ls" then
						c2.resolved_capabilities.document_formatting = false
					end
				end
				-- no need to continue first loop
				break
			end
		end
	end
	vim.api.nvim_command("lua vim.lsp.buf.formatting_sync(nil, 1000)")
	print("Formatted")
end

fns.enable_format_on_save = function()
	vim.cmd("autocmd BufWritePre <buffer> lua require('plugins.lsp.functions').format()")
	print("Enabled formatting on save")
end

fns.disable_format_on_save = function()
	vim.cmd("autocmd! BufWritePre <buffer>")
	print("Disabled formatting on save")
end

return fns
