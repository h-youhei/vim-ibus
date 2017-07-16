"return '' is for map <expr>

function! ibus#inactivate()
	exe "call system('ibus engine " . g:ibus#layout . "')"
	return ''
endfunction

function! ibus#activate()
	exe "call system('ibus engine " . g:ibus#engine . "')"
	return ''
endfunction

function! ibus#toggle()
	if ibus#is_on()
		return ibus#inactivate()
	else
		return ibus#activate()
	endif
endfunction

function! ibus#is_on()
	return system('ibus engine') =~ g:ibus#engine ? v:true : v:false
endfunction

function! ibus#inactivate_with_state()
	let b:was_ibus_on = ibus#is_on()
	return ibus#inactivate()
endfunction

function! ibus#restore_state()
	if b:was_ibus_on
		return ibus#activate()
	else
		return ibus#inactivate()
	endif
endfunction
