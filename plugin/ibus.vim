if exists('g:loaded_vim_ibus')
	finish
endif
if !executable('ibus')
	finish
endif
"ibus isn't running
if system('ibus engine') =~ 'No engine is set'
	finish
endif

if !exists('g:ibus#layout')
	echo 'Please set layout for direct input to g:ibus#layout'
	echo 'To get layout name, use this command'
	echo 'ibus list-engine'
endif
if !exists('g:ibus#engine')
	echo 'please set input method engine to g:ibus#engine'
	echo 'To get engine name, use this command'
	echo 'ibus list-engine'
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ibus#handle_insert_mode')
	let g:ibus#handle_insert_mode = v:true
endif
if !exists('g:ibus#handle_search_command')
	let g:ibus#handle_search_command = v:false
endif

augroup ibus
	autocmd!
	au BufEnter,CmdwinEnter * let b:was_ibus_on = v:false
augroup END

if g:ibus#handle_insert_mode
	augroup ibus
		au InsertEnter * call ibus#restore_state()
		au InsertLeave * call ibus#inactivate_with_state()
	augroup END
endif

if g:ibus#handle_search_command
	augroup ibus
		au CmdLineEnter [/\?] call ibus#restore_state()
		au CmdLineLeave [/\?] call ibus#inactivate_with_state()
	augroup END
endif

let g:loaded_vim_ibus = v:true

let &cpo = s:save_cpo
unlet s:save_cpo
