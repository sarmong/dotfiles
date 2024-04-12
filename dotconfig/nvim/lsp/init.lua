req("lsp.servers")
req("lsp.formatting")
req("lsp.cmp")
req("lsp.config")

req("fidget").setup({})

local function extractNames(tableList)
  local names = {}
  for _, tbl in ipairs(tableList) do
    table.insert(names, tbl.name)
  end
  return names
end

req("mason-tool-installer").setup({
  ensure_installed = extractNames(
    vim.tbl_extend(
      "force",
      req("conform").list_all_formatters(),
      req("null-ls").get_sources()
    )
  ),
})
