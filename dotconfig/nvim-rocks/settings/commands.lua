local run_file = req("modules.run-file")
local npm_run = req("modules.npm-run")
local fns = req("modules.functions")

command("RunFile", run_file)
command("NpmRun", npm_run)

-- Send output of a command to scratch buffer, useful for :messages
-- @param command string
-- @param last_n_lines ?number
command("Redir", function(ctx)
  local res = a.nvim_exec2(ctx.fargs[1], { output = true }).output
  local lines = vim.list_slice(vim.split(res, "\n", { plain = true }))
  local sliced = vim.list_slice(lines, #lines - (ctx.fargs[2] or #lines))
  vim.cmd("new")
  vim.api.nvim_buf_set_lines(0, -1, -1, false, sliced)
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

command("QfModifiedBufs", function()
  fns.qf_modified_bufs()
end)