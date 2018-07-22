# vim-ibus
vim-ibus turn off ibus when you leave INSERT mode or search command.

vim-ibus restore ibus state when you enter INSERT mode.

vim-ibus provide the way to
- get ibus status from vimscript
- turn on or off ibus from vimscript
- toggle ibus from vimscript

## Install
Set `g:ibus#layout`. To get layout name, run this command `ibus engine`.

Set `g:ibus#engine`. To get engine name, type this command `ibus engine`.
Then turn on ibus, press enter to execute above command.

For example, if you use us keyboard and mozc IME,
```
let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'mozc-jp'
