local function markdown_has_descendant_list(node)
  for child in node:iter_children() do
    if child:type() == "list" or markdown_has_descendant_list(child) then
      return true
    end
  end
  return false
end

local function markdown_line_start_col(lnum)
  local col = vim.fn.getline(lnum):find("%S")
  return col and (col - 1) or 0
end

local function markdown_node_at(row, cache)
  local node = cache[row]
  if node == nil then
    node = vim.treesitter.get_node({
      pos = { row, markdown_line_start_col(row + 1) },
    }) or false
    cache[row] = node
  end
  return node ~= false and node or nil
end

local function markdown_heading_level(node)
  local level = node and node:type():match("atx_h(%d)_marker")
  return level and tonumber(level) or nil
end

local function markdown_heading_fold_level(level)
  if not level then
    return nil
  end
  return level == 1 and 0 or (level - 1)
end

local function markdown_list_item_ancestor(node)
  local current = node
  while current and current:type() ~= "list_item" do
    current = current:parent()
  end
  return current
end

local function markdown_list_depth(list_item)
  local depth = 1
  local parent = list_item:parent()
  while parent do
    if parent:type() == "list_item" then
      depth = depth + 1
    end
    parent = parent:parent()
  end
  return depth
end

function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local node_cache = {}
  local heading_cache = {}
  -- foldexpr may ask about adjacent lines repeatedly; cache node/heading lookups
  -- within a single evaluation to avoid re-walking Treesitter for the same rows.
  local function heading_level_at(row)
    local level = heading_cache[row]
    if level == nil then
      level = markdown_heading_level(markdown_node_at(row, node_cache)) or false
      heading_cache[row] = level
    end
    return level ~= false and level or nil
  end

  local row = lnum - 1
  local node = markdown_node_at(row, node_cache)
  if not node then
    return "="
  end

  local heading_level = markdown_heading_level(node)
  if heading_level then
    local level = heading_level
    if level == 1 then
      return 0
    elseif level >= 2 and level <= 6 then
      return ">" .. (level - 1)
    end
  end

  local n = markdown_list_item_ancestor(node)
  if n and n:start() == row then
    -- A list item starts a fold if it owns another list anywhere in its
    -- subtree. Plain sibling items must still return an explicit level so they
    -- do not inherit the previous sibling's fold and get hidden underneath it.
    local has_child_list = markdown_has_descendant_list(n)

    local list_depth = markdown_list_depth(n)
    local heading_ctx = 0
    for search_row = lnum - 2, 0, -1 do
      local hlvl = heading_level_at(search_row)
      if hlvl then
        heading_ctx = markdown_heading_fold_level(hlvl)
        break
      end
    end

    if has_child_list then
      return ">" .. (heading_ctx + list_depth)
    end

    -- Reset to the current list depth for leaf items to close any preceding
    -- nested sibling fold before this line.
    return heading_ctx + list_depth - 1
  end

  if vim.fn.getline(lnum):match("^%s*$") then
    local buf_count = vim.api.nvim_buf_line_count(0)
    local next_heading_level = nil
    -- Blank lines inherit the nearest ancestor/sibling heading level relative
    -- to the next visible heading so they disappear with the correct section.
    for search_row = lnum, buf_count - 1 do
      local nl = vim.fn.getline(search_row + 1)
      if nl ~= "" and not nl:match("^%s*$") then
        next_heading_level = heading_level_at(search_row)
        break
      end
    end
    if next_heading_level then
      for search_row = lnum - 2, 0, -1 do
        local hlvl = heading_level_at(search_row)
        if hlvl and hlvl <= next_heading_level then
          return markdown_heading_fold_level(hlvl)
        end
      end
      return 0
    end
  end

  return "="
end

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
vim.opt_local.foldenable = true
vim.opt_local.foldlevelstart = 0
vim.opt_local.foldlevel = 0
vim.opt_local.foldcolumn = "1"
vim.opt_local.foldtext = ""
vim.opt_local.fillchars = "fold: "

-- For preview hover popups
if vim.api.nvim_win_get_config(0).relative ~= "" then
  vim.opt_local.foldlevelstart = 99
  vim.opt_local.foldlevel = 99
end

map("n", "<CR>", function()
  local on_heading = false
  local ok, node = pcall(vim.treesitter.get_node)
  if ok and node then
    local n = node
    if n:type() == "atx_heading" or n:parent():type() == "atx_heading" then
      on_heading = true
    end
  else
    on_heading = vim.api.nvim_get_current_line():match("^#+ ") ~= nil
  end

  if on_heading then
    vim.cmd("normal! za")
  else
    vim.api.nvim_feedkeys(vim.keycode("<CR>"), "n", false)
  end
end, { buffer = true, desc = "Toggle fold on heading" })

autocmd("InsertLeave", {
  pattern = "*.md",
  callback = function()
    vim.opt_local.foldmethod = "expr"
  end,
})
