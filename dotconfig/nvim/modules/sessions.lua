vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

local get_sessions_dir = function()
  local cwd = vim.uv.cwd()
  local dir = cwd
  local _, last_idx = vim.uv.cwd():find(os.getenv("HOME"))
  if last_idx then
    dir = cwd:sub(last_idx + 2):gsub("/", "__")
  end
  return vim.fs.joinpath(vim.fn.stdpath("state"), "sessions", dir)
end

local list_session_files = function()
  local t = {}
  for name, _ in vim.fs.dir(get_sessions_dir()) do
    local display_name = name:gsub(".vim", "")
    table.insert(t, 1, display_name)
  end
  return t
end

local get_session_filepath = function(filename)
  return vim.fs.joinpath(get_sessions_dir(), filename .. ".vim")
end

local save_session = function(suffix, name)
  suffix = suffix or "-manual"
  name = name or os.date("%y-%m-%d-%H-%M-%S")

  local sessions_dir = get_sessions_dir()

  local filepath = get_session_filepath(name .. suffix)

  if vim.fn.filereadable(filepath) == 1 then
    vim.notify("Session file exists, exiting", "error")
    return
  end

  if vim.fn.isdirectory(sessions_dir) == 0 then
    vim.fn.mkdir(sessions_dir, "p")
  end

  vim.cmd.mksession(filepath)
  vim.notify("Saved session")
end

local load_session = function(session_file)
  local bufs_to_delete = {}

  for _, bufnr in ipairs(a.nvim_list_bufs()) do
    if
      vim.fn.buflisted(bufnr) == 1
      and vim.api.nvim_buf_is_loaded(bufnr)
      and vim.api.nvim_get_current_buf() ~= bufnr
    then
      table.insert(bufs_to_delete, bufnr)
    end
  end

  if #bufs_to_delete > 0 then
    save_session("-auto")

    -- Delete all buffers to load session from scratch
    for _, bufnr in ipairs(bufs_to_delete) do
      a.nvim_buf_delete(bufnr, {})
    end
  end

  vim.cmd.source(get_session_filepath(session_file))
end

local list_sessions = function()
  local opts = {}
  local ts = lreq_submodule("telescope")

  ts.pickers
    .new(opts, {
      prompt_title = "Session files",
      finder = ts.finders.new_table({
        results = list_session_files(),
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
          }
        end,
      }),
      sorter = ts.config.values.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        map({ "i", "n" }, "<CR>", function()
          ts.actions.close(prompt_bufnr)
          local file = ts["actions.state"].get_selected_entry().value
          load_session(file)
        end)
        return true
      end,
    })
    :find()
end

command("Mksession", function(ctx)
  if ctx.fargs[1] then
    save_session("", ctx.fargs[1])
  else
    save_session()
  end
end, {
  nargs = "?",
})

command("Loadsession", function(ctx)
  if ctx.bang then
    -- TODO load latest session
    vim.notify("Bang not yet supported")
    return
  end
  if ctx.fargs[1] then
    load_session(ctx.fargs[1])
    return
  end

  list_sessions()
end, {
  complete = function()
    return list_session_files()
  end,
  nargs = "?",
  bang = true,
})

return {
  list_session_files = list_session_files,
  load_session = load_session,
  save_session = save_session,
}
