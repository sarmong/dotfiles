-- Send WINdow CHanged signal to resize nvim properly when runnin alacritty -e nvim
autocmd("VimEnter", {
  group = "Resize nvim on window resize",
  command = 'silent exec "!kill -s SIGWINCH $PPID"',
})

autocmd("VimEnter", {
  group = "Set root dir",
  callback = function()
    local rd = req("modules.root-dir")
    local root = rd.get_project_root()
    rd.set_root(root)
  end,
})

autocmd("BufReadPost", {
  group = "Jump to the latest edit position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd({ "BufNewFile", "BufRead" }, {
  group = "rasi_ft",
  pattern = "*.rasi",
  command = "set syntax=css",
})

autocmd({ "BufNewFile", "BufRead" }, {
  group = "Markdown options",
  pattern = "*.md",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.textwidth = 80
  end,
})

autocmd({ "BufReadPost" }, {
  group = "Markdown title",
  pattern = "*.md",
  callback = function(event)
    local fns = req("modules.functions")

    if fns.is_buffer_empty(event.buf) then
      local filename = fn.expand("%:t:r")
      local heading = "# " .. fns.kebab_to_sentence(filename)

      a.nvim_buf_set_lines(event.buf, 0, 3, false, { heading, "", "" })
      a.nvim_win_set_cursor(0, { 3, 0 })
      vim.opt_local.modified = true
    end
  end,
})

autocmd("TextYankPost", {
  group = "Highlight on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufWritePre", {
  group = "Remove trailing spaces",
  pattern = { "*.conf", "sxhkdrc", "lfrc", "*/newsboat/config", "*.rasi" },
  callback = function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[ %s/\s\+$//e ]])
    vim.api.nvim_win_set_cursor(0, cur)
  end,
})

autocmd("VimResized", {
  group = "Resize splits",
  command = "tabdo wincmd =",
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "tsconfig*" },
  group = "jsonc",
  command = "set filetype=jsonc",
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.json" },
  group = "json",
  callback = function()
    vim.keymap.set("n", "o", function()
      local line = vim.api.nvim_get_current_line()

      local should_add_comma = string.find(line, "[^,{[]$")
      if should_add_comma then
        return "A,<cr>"
      else
        return "o"
      end
    end, { buffer = true, expr = true })
  end,
})

autocmd("FileType", {
  pattern = "scratch",
  group = "scratch",
  callback = function()
    map("n", "gf", function()
      local path = vim.fn.expand("<cfile>")
      PickWindow(path)
    end)
  end,
})

autocmd("FileType", {
  pattern = "tsv",
  group = "tsv",
  callback = function()
    vim.opt_local.syntax = "conf"
    -- vim.opt_local.comments = ":#"
    -- vim.opt_local.commentstring = "# %s"
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 20
    vim.opt_local.softtabstop = 20
    vim.opt_local.tabstop = 20
    vim.opt_local.textwidth = 0
  end,
})

autocmd("VimEnter", {
  callback = function()
    local repo = vim.fn.argv()[1]
    if not (repo and vim.startswith(repo, "gh:")) then
      return
    end

    local dir = "/tmp/repos/" .. repo:match("/([^/]+)$")

    if vim.fn.isdirectory(dir) == 0 then
      vim.print("Cloning " .. repo:sub(3) .. " into " .. dir .. "...")
      vim.fn.system("git clone " .. repo .. " --depth=1 " .. dir)
    end

    vim.cmd.cd(dir)
    req("alpha").start()

    autocmd("VimLeave", {
      callback = function()
        vim.print("Cleaning up")
        vim.fn.delete(dir, "rf")
        vim.cmd("sleep 10m") -- @TODO prevents exit error, remove after 0.10
      end,
    })
  end,
})
