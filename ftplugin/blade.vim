" Vim filetype plugin
" Language:     Blade (Laravel)
" Maintainer:   Jason Walton <jwalton512@gmail.com>

if exists('b:did_ftplugin')
    finish
endif

runtime! ftplugin/html.vim
let b:did_ftplugin = 1

setlocal suffixesadd=.blade.php,.php
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal path+=resources/views;
setlocal include=\\w\\@<!@\\%(include\\\|extends\\)
setlocal define=\\w\\@<!@\\%(yield\\\|stack\\)

setlocal commentstring={{--%s--}}
setlocal comments+=s:{{--,m:\ \ \ \ ,e:--}}

if exists('loaded_matchit') && exists('b:match_words')
    " Append to html matchit words
    let b:match_words .= ',' .
                \ '@\%(section\s*([^\,]*)\|php\s*(\@!\|' . join(blade#standard_start_patterns, '\|') . '\)'.
                \ ':' .
                \ '@\%(' . join(blade#standard_middle_patterns, '\|') . '\)\>' .
                \ ':' .
                \ '@\%(end\w\+\|' . join(blade#standard_end_patterns, '\|') . '\)' .
                \ ',{:},\[:\],(:)'
    let b:match_skip = 'synIDattr(synID(line("."), col("."), 0), "name") !=# "bladeKeyword"'
    let b:match_ignorecase = 0
endif
