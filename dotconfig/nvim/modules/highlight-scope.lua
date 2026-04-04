-- Rewrite of https://github.com/nvim-treesitter/nvim-treesitter-refactor/blob/master/lua/nvim-treesitter-refactor/highlight_current_scope.lua
-- This module highlights the current scope of at the cursor position

local current_scope_namespace =
  vim.api.nvim_create_namespace("nvim-treesitter-current-scope")

local M = {}

local function highlight_node(node, bufnr, ns_id, hl_group)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  ns_id = ns_id or vim.api.nvim_create_namespace("my_highlight_ns")

  local start_row, start_col, end_row, end_col = node:range()

  vim.hl.range(
    bufnr,
    ns_id,
    hl_group,
    { start_row, start_col },
    { end_row, end_col }
  )
end

---@param root TSNode
---@param bufnr integer
---@param query vim.treesitter.Query
---@return TSNode[]
local function get_scopes(root, bufnr, query)
  local scopes = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "local.scope" then
      table.insert(scopes, node)
    end
  end
  return scopes
end

---@param node TSNode
---@param root TSNode
---@param bufnr integer
---@param query vim.treesitter.Query
---@param allow_scope? boolean
---@return TSNode|nil
local function containing_scope(node, root, bufnr, query, allow_scope)
  allow_scope = allow_scope == nil or allow_scope == true

  local scopes = get_scopes(root, bufnr, query)

  local iter_node = node
  while iter_node ~= nil and not vim.tbl_contains(scopes, iter_node) do
    iter_node = iter_node:parent()
  end

  return iter_node or (allow_scope and node or nil)
end

function M.highlight_current_scope(bufnr)
  M.clear_highlights(bufnr)

  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then
    return
  end

  local lang = parser:lang()
  local query = vim.treesitter.query.get(lang, "locals")
  if not query then
    return
  end

  local root = parser:parse()[1]:root()

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local node_at_point = root:named_descendant_for_range(row, col, row, col)
  if not node_at_point then
    return
  end

  local current_scope = containing_scope(node_at_point, root, bufnr, query)

  if current_scope then
    local start_line = current_scope:start()

    if start_line ~= 0 then
      highlight_node(
        current_scope,
        bufnr,
        current_scope_namespace,
        "TSCurrentScope"
      )
    end
  end
end

function M.clear_highlights(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, current_scope_namespace, 0, -1)
end

function M.enable()
  vim.api.nvim_set_hl(
    0,
    "TSCurrentScope",
    { link = "CursorLine", default = true }
  )

  autocmd("CursorMoved", {
    group = "NvimTreesitterCurrentScope",
    callback = function(event)
      M.highlight_current_scope(event.buf)
    end,
  })
  autocmd("BufLeave", {
    group = "NvimTreesitterCurrentScope",
    callback = function(event)
      M.clear_highlights(event.buf)
    end,
  })
end

function M.disable()
  M.clear_highlights(0)
  vim.api.nvim_del_augroup_by_name("NvimTreesitterCurrentScope")
end

return M
