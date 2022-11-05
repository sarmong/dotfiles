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
