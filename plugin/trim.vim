" Vim global plugin for removing trailing whitespace

" Code adapted from:
"   https://vim.fandom.com/wiki/Remove_unwanted_spaces
"   http://vimcasts.org/episodes/tidying-whitespace/

if exists("g:loaded_trim")
    finish
endif
let g:loaded_trim = 1

augroup trailingwhitespace_group
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search (search register), and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    " Clean trailing whitespace at the end of the lines
    %s/\s\+$//e
    " Clean trailing empty lines at the end of the file
    %s/\n\+\%$//e
    " Clean up:
    " Delete search history
    call histdel('/', -1)
    call histdel('/', -1)
    " Restore search register
    let @/=_s
    " Restore cursor position
    call cursor(l, c)
endfunction
