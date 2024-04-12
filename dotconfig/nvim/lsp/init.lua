req("lsp.servers")
req("lsp.formatting")
req("lsp.cmp")
req("lsp.config")

req("fidget").setup({})

local function extractNames(tableList)
  local names = {}
  for _, tbl in ipairs(tableList) do
    for _, source in ipairs(tbl) do
      table.insert(names, source.name)
    end
  end
  return names
end

req("mason-tool-installer").setup({
  ensure_installed = extractNames({
    req("conform").list_all_formatters(),
    req("null-ls").get_sources(),
  }),
})
