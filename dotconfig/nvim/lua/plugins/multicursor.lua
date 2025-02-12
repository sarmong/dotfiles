Plugin("jake-stewart/multicursor.nvim")

local mc = req("multicursor-nvim")

mc.setup()

-- Add or skip cursor above/below the main cursor.
map({ "n", "x" }, "<up>", function()
  mc.lineAddCursor(-1)
end)
map({ "n", "x" }, "<down>", function()
  mc.lineAddCursor(1)
end)
map({ "n", "x" }, "<leader><up>", function()
  mc.lineSkipCursor(-1)
end)
map({ "n", "x" }, "<leader><down>", function()
  mc.lineSkipCursor(1)
end)

-- Add or skip adding a new cursor by matching word/selection
map({ "n", "x" }, "<C-n>", function()
  mc.matchAddCursor(1)
end)

-- Add all matches in the document
map({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

-- Rotate the main cursor.
map({ "n", "x" }, "<left>", mc.nextCursor)
map({ "n", "x" }, "<right>", mc.prevCursor)

-- Add and remove cursors with control + left click.
map("n", "<c-leftmouse>", mc.handleMouse)

-- Easy way to add and remove cursors using the main cursor.
map({ "n", "x" }, "<c-q>", mc.toggleCursor)

map("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    -- Default <esc> handler.
  end
end)

-- Append/insert for each line of visual selections.
map("x", "I", mc.insertVisual)
map("x", "A", mc.appendVisual)

-- match new cursors within visual selections by regex.
map("x", "M", mc.matchCursors)

-- Customize how cursors look.
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
