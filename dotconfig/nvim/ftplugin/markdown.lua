function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)
  local heading = line:match("^(#+)%s")
  if heading then
    local level = #heading
    if level == 1 then
      return 0 -- H1 is never folded
    elseif level >= 2 and level <= 6 then
      -- Shift by 1 so H2=level1, H3=level2, etc. — avoids skipping from H1's
      -- level 0 to level 2, which Vim interprets as an implicit level-1 fold.
      return ">" .. (level - 1)
    end
  end
  -- For blank lines between sections: if next non-blank line is a shallower
  -- heading than the previous one, lift the blank line to that heading's level
  -- so it stays visible when the deeper section is folded.
  if line:match("^%s*$") then
    local prev_depth = 0
    for i = lnum - 1, 1, -1 do
      local prev_heading = vim.fn.getline(i):match("^(#+)%s")
      if prev_heading then
        prev_depth = #prev_heading
        break
      end
    end
    if prev_depth > 0 then
      for i = lnum + 1, vim.fn.line("$") do
        local next_line = vim.fn.getline(i)
        if next_line:match("%S") then
          local next_heading = next_line:match("^(#+)%s")
          if next_heading and #next_heading < prev_depth then
            return math.max(0, #next_heading - 1)
          end
          break
        end
      end
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
    vim.opt.foldmethod = "expr"
  end,
})
