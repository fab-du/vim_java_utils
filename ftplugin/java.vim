
"
"global variable from plugin java_gettersetter
"disable all mappings this plugins did 
"
let g:no_plugin_maps = 1

"Compiler set
compiler ant
set makeprg=maven\ -q\ -f\ project.xml\ jar:install

iab <buffer> <unique> ,f <C-r>=expand('%:t:r')<CR>
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set fmr=/**,*/ fdm=marker fdc=1
set fdm "/**,*/"

set wildmode=list:longest

let java={}
nnoremap <leader>jo :call java.open(expand('<cWORD>'))<cr>
nnoremap <leader>ji :call java.implementors(expand('<cWORD>'))<cr>

function! java.open(class)
    let path = system('find src -name ' . a:class . '.java')
    execute "edit " . path
endfunction

function! java.implementors(interface)
    execute 'vimgrep /implements.*.' . a:interface . '/ src/**/*.java'
endfunction



function! InsertJavaPackage()
  let filename = expand("%")
  let filename = substitute(filename, "\.java$", "", "")
  let dir = getcwd() . "/" . filename
  let dir = substitute(dir, "^.*\/src\/", "", "")
  let dir = substitute(dir, "\/[^\/]*$", "", "")
  let dir = substitute(dir, "\/", ".", "g")
  let filename = substitute(filename, "^.*\/", "", "")
  let dir = "package " . dir . ";"
  let result = append(0, dir)
  let result = append(1, "")
  let result = append(2, "class " . filename . " {")
  let result = append(4, "}")
endfunction
