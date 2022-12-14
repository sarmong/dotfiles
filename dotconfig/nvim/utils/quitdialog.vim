function! quitdialog#promptchar(msg)
	echo a:msg
	redraw
	return nr2char(getchar())
endfunction

function! quitdialog#promptyn(msg, default)
	let l:suffix = a:default ? '[y]/n' : 'y/[n]'
	let l:msg = a:msg . ' (' . l:suffix . ')'
	let l:ch = quitdialog#promptchar(l:msg)
	if a:default
		return l:ch !=? 'n'
	else
		return l:ch ==? 'y'
	endif
endfunction

function! quitdialog#quithandler()
	if !quitdialog#promptyn('Exit Vim?', v:true)
		let l:lz = &lazyredraw
		set lazyredraw
		tabnew
		set modified
		echo ''
		let l:win = win_getid()
    echo win_getid()
		call timer_start(0, {-> win_gotoid(l:win) && execute('q! | redraw')})
	endif
endfunction

aug quitdialog
	au!
	au ExitPre * call quitdialog#quithandler()
aug END

lua << EOF
-- create_autocmd("ExitPre", {
--   group = create_augroup("quitdialog"),
--   pattern = "*",
--   callback = function()
--     vim.ui.input({ prompt = "Exit Vim?" }, function(input)
--       if input == "n" then
--         local prev_lz = vim.o.lazyredraw
--         vim.o.lazyredraw = true
--         vim.cmd("tabnew")
--         vim.bo.modified = true
--         print("")
--         local win_id = vim.api.nvim_get_current_win()
--         print(win_id)
--         local timer = vim.loop.new_timer()
--         timer:start(0, 0, function()
--           timer:stop()
--           timer:close()
--           vim.api.nvim_set_current_win(win_id)
--           vim.cmd("q! | redraw")
--         end)
--         --[[ vim.cmd([[ ]]
--         --[[   let l:win = win_getid() ]]
--         --[[   call timer_start(0, {-> win_gotoid(l:win) && execute('q! | redraw')}) ]]
--         -- ]])
--
--         vim.o.lazyredraw = prev_lz
--       end
--     end)
--   end,
-- })
EOF
