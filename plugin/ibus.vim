let g:ibus#layout = 'BambooUs'
let g:ibus#engine = 'BambooUs'

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
	echo 'To get layout name, turn off ibus then use this command'
	echo 'ibus engine'
endif
if !exists('g:ibus#engine')
	echo 'please set input method engine to g:ibus#engine'
	echo 'To get engine name, type this command'
	echo 'ibus engine'
	echo 'turn on ibus, press enter to execute above command'
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ibus#insert_mode_behavior')
	let g:ibus#insert_mode_behavior = 'restore'
endif
if !exists('g:ibus#commandline_behavior')
	let g:ibus#commandline_behavior = 'off'
endif

"remove these lines on 2019/07/14
if exists('g:ibus#handle_insert_mode')
	echo 'g:ibus#handle_insert_mode is removed.'
	echo 'use g:ibus#insert_mode_behavior instead'
endif
if exists('g:ibus#handle_search_command')
	echo 'g:ibus#handle_search_command is removed.'
	echo 'use g:ibus#commandline_behavior instead'
endif

augroup ibus
	autocmd!
	au BufEnter,CmdwinEnter * let b:was_ibus_on = v:false
augroup END

if g:ibus#insert_mode_behavior == 'restore'
	augroup ibus
		au InsertEnter * call ibus#restore_state()
		au InsertLeave * call ibus#inactivate_with_state()
	augroup END
elseif g:ibus#insert_mode_behavior == 'off'
	augroup ibus
		au InsertLeave * call ibus#inactivate()
	augroup END
endif

if g:ibus#commandline_behavior == 'restore'
	augroup ibus
		au CmdLineEnter [/\?] call ibus#restore_state()
		au CmdLineLeave [/\?] call ibus#inactivate_with_state()
		au CmdLineLeave : call ibus#inactivate()
	augroup END
elseif g:ibus#commandline_behavior == 'off'
	augroup ibus
		au CmdLineLeave * call ibus#inactivate()
	augroup END
endif

let g:loaded_vim_ibus = v:true

let &cpo = s:save_cpo
unlet s:save_cpo
