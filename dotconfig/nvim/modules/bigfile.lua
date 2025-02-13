local opts = {
  size = 1.5 * 1024 * 1024, -- 1.5MB
  line_length = 1000, -- max average line length
}

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        if not path or not buf or vim.bo[buf].filetype == "bigfile" then
          return
        end
        local size = vim.fn.getfsize(path)
        if size <= 0 then
          return
        end
        if size > opts.size then
          return "bigfile"
        end
        local lines = vim.api.nvim_buf_line_count(buf)
        return (size - lines) / lines > opts.line_length and "bigfile" or nil
      end,
    },
  },
})

autocmd("FileType", {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":~:.")

    vim.notify(
      ("Big file detected `%s`."):format(path)
        .. " Some Neovim features have been disabled.",
      vim.log.levels.WARN
    )

    if vim.fn.exists(":NoMatchParen") ~= 0 then
      vim.cmd([[NoMatchParen]])
    end

    vim.opt_local.foldmethod = "manual"
    vim.opt_local.statuscolumn = ""
    vim.opt_local.conceallevel = 0

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
      end
    end)
  end,
})
