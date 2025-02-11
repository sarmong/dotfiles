Plugin({
  source = "sarmong/neoconf.nvim",
  depends = { "neovim/nvim-lspconfig" },
})

local nc = req("neoconf")

nc.setup()

local get = function(...)
  local keys = { ... }
  for _, key in ipairs(keys) do
    local val = nc.get(key)
    if val then
      return val
    end
  end
  return {}
end

local get_table_keys = function(tab)
  local keyset = {}
  for k in pairs(tab) do
    keyset[#keyset + 1] = k
  end

  return keyset
end

local get_current_theme = function()
  local ok, fd =
    pcall(io.open, os.getenv("XDG_STATE_HOME") .. "/current_theme", "r")

  if not ok or not fd then
    return "dark"
  end

  ---@type string
  local data = fd:read("*line")
  fd:close()
  return data
end

_G.Pref = {
  ui = {
    colorscheme = "gruvbox-material",
    background = get_current_theme,
  },

  search = {
    exclude = vim.list_extend(
      get_table_keys(get("vscode.search.exclude")),
      get("search.exclude")
    ) or {},
  },

  ide = {
    format_on_save = true,
    virtual_text = false,
  },
}
