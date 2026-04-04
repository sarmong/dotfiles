-- Rewrite of https://github.com/nvim-treesitter/nvim-treesitter-refactor/blob/master/lua/nvim-treesitter-refactor/highlight_definitions.lua
-- This module highlights reference usages and the corresponding
-- definition on cursor hold.

local usage_namespace = vim.api.nvim_create_namespace("nvim-treesitter-usages")

local M = {}

local function highlight_node(node, bufnr, ns_id, hl_group)
  local start_row, start_col, end_row, end_col = node:range()

  vim.hl.range(
    bufnr,
    ns_id,
    hl_group,
    { start_row, start_col },
    { end_row, end_col }
  )
end

-- Walk up from descendant to check if ancestor contains it
local function node_contains(ancestor, descendant)
  local node = descendant
  while node do
    if node == ancestor then return true end
    node = node:parent()
  end
  return false
end

-- Find the nearest enclosing @local.scope node for a definition node
local function scope_for_def(def_node, root, bufnr, query)
  local scope = def_node:parent()
  while scope do
    for sid, scope_node in query:iter_captures(root, bufnr, 0, -1) do
      if query.captures[sid] == "local.scope" and scope_node == scope then
        return scope_node
      end
    end
    scope = scope:parent()
  end
  return root
end

local function find_definition(ref_node, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then return nil end

  local lang = parser:lang()
  local query = vim.treesitter.query.get(lang, "locals")
  if not query then return nil end

  local root = parser:parse()[1]:root()
  local ref_text = vim.treesitter.get_node_text(ref_node, bufnr)

  -- Among all matching definitions whose scope contains ref_node, pick the innermost
  local best_def, best_scope, best_kind
  local best_row = -1

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if vim.startswith(name, "local.definition")
      and vim.treesitter.get_node_text(node, bufnr) == ref_text
    then
      local scope = scope_for_def(node, root, bufnr, query)
      if node_contains(scope, ref_node) then
        local s_row = scope:range()
        if s_row > best_row then
          best_def, best_scope, best_kind = node, scope, name
          best_row = s_row
        end
      end
    end
  end

  return best_def, best_scope, best_kind
end

local function find_usages(def_node, scope, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  local query = vim.treesitter.query.get(lang, "locals")
  if not query then return {} end

  local def_text = vim.treesitter.get_node_text(def_node, bufnr)
  local s_row, _s_col, e_row = scope:range()

  local usages = {}
  for id, node in query:iter_captures(scope, bufnr, s_row, e_row + 1) do
    if query.captures[id] == "local.reference"
      and vim.treesitter.get_node_text(node, bufnr) == def_text
    then
      table.insert(usages, node)
    end
  end

  return usages
end

function M.highlight_usages(bufnr)
  local node_at_point = vim.treesitter.get_node()

  M.clear_usage_highlights(bufnr)
  if not node_at_point then
    return
  end

  local def_node, scope = find_definition(node_at_point, bufnr)
  if not def_node then
    return
  end
  local usages = find_usages(def_node, scope, bufnr)

  for _, usage_node in ipairs(usages) do
    if usage_node ~= node_at_point and usage_node ~= def_node then
      highlight_node(usage_node, bufnr, usage_namespace, "TSDefinitionUsage")
    end
  end

  if def_node ~= node_at_point then
    highlight_node(def_node, bufnr, usage_namespace, "TSDefinition")
  end
end

function M.has_highlights(bufnr)
  return #vim.api.nvim_buf_get_extmarks(bufnr, usage_namespace, 0, -1, {}) > 0
end

function M.clear_usage_highlights(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, usage_namespace, 0, -1)
end

function M.enable()
  vim.api.nvim_set_hl(0, "TSDefinition", { link = "Search", default = true })
  vim.api.nvim_set_hl(
    0,
    "TSDefinitionUsage",
    { link = "Visual", default = true }
  )
  autocmd("CursorHold", {
    group = "NvimTreesitterUsages",
    callback = function(event)
      if vim.treesitter.get_parser(event.buf, nil, { error = false }) then
        M.highlight_usages(event.buf)
      end
    end,
  })
  autocmd({ "CursorMoved", "InsertEnter" }, {
    group = "NvimTreesitterUsages",
    callback = function(event)
      if vim.treesitter.get_parser(event.buf, nil, { error = false }) then
        M.clear_usage_highlights(event.buf)
      end
    end,
  })
end

function M.disable()
  M.clear_usage_highlights(0)
  vim.api.nvim_del_augroup_by_name("NvimTreesitterUsages")
end

return M
