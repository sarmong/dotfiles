-- for some reason in vim _ and / are swapped
vim.api.nvim_set_keymap(
  "n",
  "<C-_>",
  "<Plug>(comment_toggle_current_linewise)",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<C-_>",
  "<Plug>(comment_toggle_linewise_visual)",
  { noremap = true, silent = true }
)

-- taken from https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
req("Comment").setup({
  pre_hook = function(ctx)
    local U = req("Comment.utils")

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = req("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location =
        req("ts_context_commentstring.utils").get_visual_start_location()
    end

    return req("ts_context_commentstring.internal").calculate_commentstring({
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    })
  end,
})
