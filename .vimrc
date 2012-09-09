set nocompatible
set ch=2 " Make command line two lines high
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1,ucs-bom,ucs
set fencs=utf-8,cp936,big5,gb18030,gb2312,ucs-bom
set enc=utf-8
set display=lastline " 不显示@
set mousehide       
set nu
set cindent
set backspace=indent,eol,start
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8 "vim: set ts=8 sts=4
set hlsearch
set mouse=a
set nocp
set autochdir
set grepprg=grep\ -nH\ $*
set nobackup
set ru
set pastetoggle=<F3>
set clipboard=unnamedplus
syntax on
syntax enable

hi Comment ctermfg=6

let c_comment_strings=1 " I like highlighting strings inside C comments
autocmd FileType c set makeprg=gcc\ -Wall\ %\ -o\ %:t:r
autocmd FileType cpp set makeprg=g++\ -Wall\ %\ -o\ %:t:r
au BufRead,BufNewFile *.txt setlocal ft=txt
nnoremap <F9> :w<cr>:make<cr>:cw<cr>
nnoremap <F10> :!./%:t:r<cr>
nnoremap <F5> :!./%<cr>
nnoremap <C-a> ggVG

filetype plugin indent on

" TagList
ca tl Tlist
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open = 1
let Tlist_Show_One = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Ctags_Cmd="ctags"
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"set tags+=~/.tags/c++.tags

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set completeopt=menu

" pathogen
" call pathogen#runtime_append_all_bundles() 

"NERDTree
ca nt NERDTreeToggle
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0

ca qq q!
ca w!! w !sudo tee >/dev/null "%"
