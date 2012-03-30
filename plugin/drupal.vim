iabbr Hook <C-R>=HookFunc()<CR>

" HookFunc(): Drupal helper function
function! HookFunc()
  let f = strpart(expand("%:t"), 0, stridx(expand("%:t"), '.', 0))
  let h = substitute(input("Enter hook name: "), " ", "", "g")
  return CommentBlock("Implements hook_" . h) . "function " . f . "_" . h . "() {\<CR>}\<ESC>k%i"
endfunction

function! CommentBlock(comment)
  let beginner =  "/**"
  let line_char =  " *"
  let ender = "*/"

  " Build the comment box and put the comment inside it...
  return beginner . "\<CR>" . line_char . a:comment . "().\<CR>" . ender . "\<CR>\<ESC>0i"
endfunction

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif

