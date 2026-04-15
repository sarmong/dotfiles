-- Need to have the tree parsed before foldexpr is called
vim.treesitter.get_parser(0):parse()

function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local heading_level = vim.treesitter
    .get_node({ pos = { lnum - 1, 0 } })
    :type()
    :match("atx_h(%d)_marker")

  if heading_level then
    local level = tonumber(heading_level)
    if level == 1 then
      return 0 -- H1 is never folded
    elseif level >= 2 and level <= 6 then
      -- Shift by 1 so H2=level1, H3=level2, etc. — avoids skipping from H1's
      -- level 0 to level 2, which Vim interprets as an implicit level-1 fold.
      return ">" .. (level - 1)
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
    vim.opt.foldmethod = "expr"
  end,
})
