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
	echo 'please set layout for direct input to  g:ibus#layout'
endif
if !exists('g:ibus#engine')
	echo 'please set input method engine to g:ibus#engine'
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
augroup END

if g:ibus#handle_insert_mode
	augroup ibus
		au BufEnter,CmdwinEnter * let b:was_ibus_on = v:false
		au InsertEnter * call ibus#restore_state()
		au InsertLeave * call ibus#inactivate_with_state()
	augroup END
endif

if g:ibus#handle_search_command
	nnoremap <expr> / (ibus# restore_state() . '/')
	nnoremap <expr> ? (ibus#restore_state() . '?')
	cnoremap <expr> <CR> (ibus#inactivate_with_state() . '<CR>')
	"<C-u><BS> is used because <Esc> doesn't work properly
	cnoremap <expr> <Esc> (ibus#inactivate_with_state() . '<C-u><BS>')
endif

let g:loaded_vim_ibus = v:true

let &cpo = s:save_cpo
unlet s:save_cpo
