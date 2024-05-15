if exists('g:loaded_incr')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! -range IncrInt lua require('incr').incrInt()
command! -range IncrIntBy lua require('incr').incrIntBy()

let g:loaded_incr = 1
