local function encrypt_file_on_save(encrypted_file_path)
  local file_path = fn.expand("%:p")

  local command = os.getenv("XDG_DOTFILES_DIR")
    .. "/Taskfile ansible reencrypt "
    .. file_path

  autocmd("BufWritePost", {
    group = "Vault - reencrypt",
    buffer = 0,
    callback = function()
      local code = system(command):wait().code

      if code > 0 then
        vim.notify_once(
          "Could not save encrypted file, try running 'Taskfile gen_vault_pass'",
          vim.log.levels.ERROR
        )
      else
        vim.notify("Written to " .. encrypted_file_path, vim.log.levels.INFO)
      end
    end,
  })
end

autocmd("BufRead", {
  group = "Vault - check reencrypt",
  callback = function()
    local current_buf = a.nvim_get_current_buf()
    local last_line = a.nvim_buf_get_lines(current_buf, -2, -1, true)[1]

    local file_path =
      last_line:match("## Encrypted with ansible vault %- ([%w%p]+)")

    if file_path then
      encrypt_file_on_save(file_path)
    end
  end,
})
