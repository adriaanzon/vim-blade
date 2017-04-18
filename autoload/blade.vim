let blade#directives_with_parentheses = [
      \   'if', 'elseif', 'hasSection', 'unless',
      \   'foreach', 'forelse', 'for', 'while', 'break', 'continue',
      \   'can', 'cannot', 'elsecan', 'elsecannot',
      \   'include', 'includeIf', 'each',
      \   'inject',
      \   'extends',
      \   'section', 'yield', 'parent',
      \   'stack', 'push',
      \   'php', 'unset',
      \   'lang', 'choice',
      \   'component', 'slot'
      \ ]
let blade#directives_with_parentheses += get(g:, 'blade_custom_directives', [])
let blade#directives_with_parentheses += keys(get(g:, 'blade_custom_directives_pairs', {}))

let blade#directives_without_parentheses = [
      \   'else', 'endif', 'endunless',
      \   'endfor', 'endforeach', 'empty', 'endforelse', 'endwhile',
      \   'endcan', 'endcannot',
      \   'stop', 'append', 'endsection', 'show', 'overwrite',
      \   'endpush', 'endprepend',
      \   'verbatim', 'endverbatim',
      \   'endcomponent', 'endslot',
      \ ]
let blade#directives_with_parentheses += values(get(g:, 'blade_custom_directives_pairs', {}))

let blade#all_directives = blade#directives_with_parentheses + blade#directives_without_parentheses

" These are called patterns, because only the beginning of a directive needs
" to be matched, e.g. @end* @for* @else*
let blade#start_patterns = ['if', 'unless', 'for', 'while', 'section', 'push', 'prepend', 'can', 'hasSection', 'verbatim', 'component', 'slot', 'php', 'section']
let blade#middle_patterns = ['else', 'empty']
let blade#end_patterns = ['end', 'stop', 'show', 'append', 'overwrite']

let blade#start_patterns += keys(get(g:, 'blade_custom_directives_pairs', {}))
let blade#end_patterns += values(get(g:, 'blade_custom_directives_pairs', {}))

" Directives with special behavior
" @php directives only are multiline when they have no argument
" @section directives only are multiline when they have no second argument
let blade#special_directives = ['php', 'section']

" Directives with standard behavior
function! s:without(list, remove)
  return filter(copy(a:list), 'index(' . string(a:remove) . ', v:val) == -1')
endfunction
let blade#standard_directives = s:without(blade#all_directives, blade#special_directives)
let blade#standard_directives_with_parentheses = s:without(blade#directives_with_parentheses, blade#special_directives)
let blade#standard_directives_without_parentheses = s:without(blade#directives_without_parentheses, blade#special_directives)
let blade#standard_start_patterns = s:without(blade#start_patterns, blade#special_directives)
let blade#standard_middle_patterns = s:without(blade#middle_patterns, blade#special_directives)
let blade#standard_end_patterns = s:without(blade#end_patterns, blade#special_directives)
