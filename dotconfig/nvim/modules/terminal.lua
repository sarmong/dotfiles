-- Split terminal integrated with tmux nested session
--
-- TODO:
--   - set splitkeep only temporarily and return the cursor on the prev line

local prev_win_id = nil
local term_buf = nil
local term_buf_name = "Terminal"

local function kill_terminal()
  local term_winnr = fn.bufwinid(term_buf)
  if term_winnr >= 0 then
    a.nvim_win_close(term_winnr, false)
  end
  if term_buf then
    a.nvim_buf_delete(term_buf, { force = true })
    term_buf = nil
  end
end

local function fix_win_widths()
  local wins = a.nvim_list_wins()
  local tree_win
  local widths = {}
  for _, win in ipairs(wins) do
    local buf = a.nvim_win_get_buf(win)
    local fullname = a.nvim_buf_get_name(buf)
    local path_items = vim.split(fullname, "/")
    local basename = path_items[#path_items]
    if not basename.find(basename, term_buf_name) then
      widths[win] = a.nvim_win_get_width(win)
    end
    if basename.find(basename, "NvimTree_%d") then
      tree_win = win
    end
  end

  if tree_win then
    a.nvim_set_current_win(tree_win)
    cmd.wincmd("L")
  end

  -- Reverse order, so that NvimTree win (rightmost) is updated the first, otherwise won't work correctly
  for i = #wins, 1, -1 do
    local win = wins[i]
    if widths[win] then
      a.nvim_win_set_width(win, widths[win])
    end
  end
end

local function open_term(winnr)
  if not term_buf then
    print("Cannot open non-existing term buffer")
    return
  end
  local new_term_winnr = winnr
    or a.nvim_open_win(term_buf, true, { split = "below", win = 0 })
  cmd.wincmd("J")

  fix_win_widths()
  a.nvim_set_current_win(new_term_winnr)

  a.nvim_set_option_value("number", false, { scope = "local" })
  a.nvim_set_option_value("relativenumber", false, { scope = "local" })
  -- a.nvim_set_option_value("bufhidden", "hide", { scope = "local" })

  autocmd("WinLeave", {
    pattern = term_buf_name,
    once = true, -- with group instead?
    callback = function()
      prev_win_id = nil
    end,
  })

  autocmd("BufEnter", {
    nested = true,
    group = "Terminal last window - close vim",
    callback = function()
      if
        #vim.api.nvim_list_wins() == 1
        and vim.opt.buftype:get() == "terminal"
      then
        vim.cmd("quit")
      end
    end,
  })
end

local function create_term()
  local output_buf = a.nvim_create_buf(false, false)
  term_buf = output_buf
  local output_win =
    a.nvim_open_win(output_buf, true, { split = "below", win = 0 })

  local is_in_tmux = os.getenv("TMUX")

  if not is_in_tmux then
    fn.termopen("zsh")
  else
    local current_session =
      system("tmux display-message -p #S"):wait().stdout:gsub("\n", "")

    local nested_name = "nested-" .. current_session
    local nested_session_exists =
      system("tmux has-session -t " .. nested_name):wait().code

    if nested_session_exists == 0 then
      fn.termopen("TMUX= tmux attach -t " .. nested_name)
    else
      fn.termopen("zsh")
    end
  end

  a.nvim_buf_set_name(output_buf, term_buf_name)

  open_term(output_win)

  map({ "n", "i", "t" }, "<C-,>", function()
    local term_win_id = fn.bufwinid(output_buf)
    local win = prev_win_id or fn.win_getid(fn.winnr("#"))
    a.nvim_set_current_win(win)
    a.nvim_win_close(term_win_id, false)
  end, { buffer = output_buf })

  -- A way to kill this buffer in order to recreate it if nested session was created or remove
  map({ "n", "i", "t" }, "ZQ", function()
    kill_terminal()
  end, { buffer = output_buf })
end

local function toggle_terminal()
  if not term_buf then
    prev_win_id = fn.win_getid(fn.winnr())
    create_term()
    return
  end

  local term_win_id = fn.bufwinid(term_buf)

  if term_win_id < 0 then
    prev_win_id = fn.win_getid(fn.winnr())
    open_term()
    return
  end

  local win = prev_win_id or fn.win_getid(fn.winnr("#"))
  a.nvim_set_current_win(win)
  a.nvim_win_close(term_win_id, false)
end

map("n", "<C-,>", function()
  toggle_terminal()
end, "open terminal")

command("Terminal", function(args)
  if args.bang then
    local term_winnr = fn.bufwinid(term_buf)
    kill_terminal()

    if term_winnr < 0 then -- recreate if was closed
      toggle_terminal()
    end
  else
    toggle_terminal()
  end
end, { bang = true })
