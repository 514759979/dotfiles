set nocompatible
"set ch=2
set fileencodings=utf-8,gb18030
set fencs=utf-8,gb18030
set enc=utf-8
set ambiwidth=double
set display=lastline " 不显示@
set mousehide
set nu
set cindent
set backspace=indent,eol,start
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4 "vim: set ts=8 sts=4
set hlsearch
set mouse=a
set nocp
set autochdir
set nobackup
set ru
"set clipboard=unnamedplus
syntax on
syntax enable
filetype plugin indent on

"{{{ taglist
ca tl Tlist
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open = 1
let Tlist_Show_One = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Ctags_Cmd="ctags"
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
"let Tlist_WinWidth=30
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"set tags+=~/.tags/c++.tags
"}}}

"{{{ omnicppcomplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set completeopt=menu
"}}}

"{{{ yong
function Im2en()
   let a = system("yong-vim 1")
endfunction
function Im2zh()
   let a = system("yong-vim 0")
endfunction

set timeoutlen=100
autocmd! InsertLeave * call Im2en()
autocmd! InsertEnter * call Im2zh()
"}}}

"{{{ winmanager
let g:winManagerWindowLayout = "BufExplorer|FileExplorer"
ca nt WMT
ca NT WMT
"}}}
"
"{{{ bufexplorer
let g:bufExplorerSortBy='name'
"}}}

set pastetoggle=<F3>
hi Comment ctermfg=6
" I like highlighting strings inside C comments
let c_comment_strings=1
autocmd FileType c set makeprg=gcc\ -Wall\ %\ -o\ %:t:r
autocmd FileType cpp set makeprg=g++\ -Wall\ %\ -o\ %:t:r
autocmd FileType go set makeprg=go\ build\ %
au BufRead,BufNewFile *.txt setlocal ft=txt
nnoremap <F9> :w<cr>:make<cr>:cw<cr>
nnoremap <F10> :!./%:t:r<cr>
nnoremap <F5> :!./%<cr>
nnoremap <C-a> ggVG
ca qq q!
ca w!! w !sudo tee >/dev/null "%"
"set t_ti= t_te=
nnoremap <F2> :set mouse=<cr>:set nonu<cr>
nnoremap <F4> :set mouse=a<cr>:set nu<cr>
map <C-c> "+y
nmap k gk
nmap j gj
nmap 0 g0
nmap $ g$
vmap $ g$
vmap 0 g0
vmap k gk
vmap j gj
set statusline=%F%m%r%h%w\ [%Y:%{&fenc!=''?&fenc:&enc}]\ [%l/%L,%p%%,%v]
set laststatus=2
ca tt tabe
map <C-j> :tabprevious<cr>
map <C-k> :tabnext<cr>
map <esc>j :next<cr>
map <esc>k :previous<cr>

au BufRead,BufNewFile *.thrift set filetype=thrift
