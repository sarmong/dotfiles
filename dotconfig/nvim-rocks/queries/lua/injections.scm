((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    (string
      content: _ @injection.content)))
  (#set! injection.language "vim")
  (#any-of? @_vimcmd_identifier
    "cmd" "cmd.bind" "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_command" "vim.api.nvim_exec2"))
