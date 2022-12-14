-- Load custom tree-sitter grammar for org filetype

req("orgmode").setup({
  org_agenda_files = { "~/docs/nextcloud/Vault/org/*" },
  org_default_notes_file = "~/docs/nextcloud/Vault/org/refile.org",
})

-- req("headlines").setup()

req("org-bullets").setup({
  concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
  symbols = {
    headlines = { "◉", "○", "✸", "✿" },
    checkboxes = {
      cancelled = { "", "OrgCancelled" },
      done = { "✓", "OrgDone" },
      todo = { "˟", "OrgTODO" },
    },
  },
})

local function format()
  local fn = vim.fn
  local a = vim.api

  local cursor = a.nvim_win_get_cursor(0)
  local cursor_win_pos = fn.screenpos(0, unpack(cursor)).row

  vim.cmd("norm gg=G")

  a.nvim_win_set_cursor(0, cursor)
  local new_cursor_win_pos = fn.screenpos(0, unpack(cursor)).row

  if cursor_win_pos == new_cursor_win_pos then
    return
  elseif cursor_win_pos > new_cursor_win_pos then
    local offset = cursor_win_pos - new_cursor_win_pos
    local ctrl_y = a.nvim_replace_termcodes("<C-y>", true, false, true)
    a.nvim_feedkeys(offset .. ctrl_y, "n", false)
  elseif cursor_win_pos < new_cursor_win_pos then
    local offset = new_cursor_win_pos - cursor_win_pos
    local ctrl_e = a.nvim_replace_termcodes("<C-e>", true, false, true)
    a.nvim_feedkeys(offset .. ctrl_e, "n", false)
  end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.create_augroup("org_ft"),
  pattern = "*.org",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.concealcursor = "nc"
    vim.opt_local.foldexpr = "OrgmodeFoldExpr()"
    vim.opt_local.foldenable = true
    vim.opt_local.tabstop = 1
    vim.opt_local.shiftwidth = 1
    vim.opt_local.textwidth = 80
    vim.cmd("IndentBlanklineDisable")
  end,
})

return {
  format = format,
}
