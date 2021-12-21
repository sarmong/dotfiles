-- vim.api.nvim_set_var("fzf_layout",  { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } })
-- vim.api.nvim_set_var("fzf_layout", { 'window': '-tabnew' })
vim.api.nvim_set_var("fzf_layout", { down = "40%" })

vim.api.nvim_set_var("fzf_action", {
  ["ctrl-x"] = "split",
  ["ctrl-v"] = "vsplit",
})

-- this makes :Rg not search filenames
-- https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
-- vim.cmd(
--   [[command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)]]
-- )

vim.cmd(
  "command! -bang -nargs=* Rg call fzf#vim#rg(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)"
)

vim.cmd(
  [[command! -bang -nargs=* Rg call fzf#vim#grep( 'rg --column --line-number --no-heading --color=always --smart-case --hidden --require-git -g="!.git/**/*" -- '.shellescape(<q-args>), 0, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
]]
)
