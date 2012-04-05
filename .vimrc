set nocompatible
set ch=2        " Make command line two lines high
"set cursorline
" 设置多编码文本
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1,ucs-bom,ucs
set fencs=utf-8,cp936,big5,gb18030,gb2312,ucs-bom
set enc=utf-8
"当设置下面一行时无论所打开文件是否为utf-8编码，保存时都会强制保存为utf-8格式
"set fenc=utf-8
"不显示@
set display=lastline 
set mousehide       
set nu
set cindent
set backspace=indent,eol,start
set smartindent
"tab size
set expandtab "用空格
set shiftwidth=4
set softtabstop=4
set tabstop=8 "vim: set ts=8 sts=4
syntax on
autocmd FileType c set makeprg=gcc\ -Wall\ %\ -o\ %:t:r
autocmd FileType cpp set makeprg=g++\ -Wall\ %\ -o\ %:t:r
nnoremap <F9> :w<cr>:make<cr>:cw<cr>
nnoremap <F10> :!./%:t:r<cr>
nnoremap <F5> :!./%<cr>
nnoremap <C-a> ggVG

" I like highlighting strings inside C comments
let c_comment_strings=1
set hlsearch
set mouse=a
filetype plugin on
syntax enable
colorscheme elflord
filetype plugin indent on
set nocp
filetype indent on
set autochdir
set grepprg=grep\ -nH\ $*
set nobackup
set ru
set pastetoggle=<F3>

" TagList
let Tlist_Auto_Open = 1
let Tlist_Show_One = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Ctags_Cmd="ctags"
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"set tags+=~/.tags/c++.tags
"Paste toggle – when pasting something in, don’t indent.

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set completeopt=menu

""fcitx4vim
"let g:input_toggle = 0
"function Fcitx2en() 
"	let s:input_status = system("fcitx-remote")
"	if s:input_status == 2
"		let g:input_toggle = 1
"		let l:a = system("fcitx-remote -c")
"	endif
"endfunction
""
"function Fcitx2zh() 
"	let s:input_status = system("fcitx-remote")
"	if s:input_status != 2 && g:input_toggle == 1
"		let l:a = system("fcitx-remote -o")
"		let g:input_toggle = 0
"	endif
"endfunction

"set timeoutlen=150
"autocmd! InsertLeave * call Fcitx2en()
"autocmd! InsertEnter * call Fcitx2zh()

call pathogen#runtime_append_all_bundles() 

set clipboard=unnamedplus

"NERDTree
ca nt NERDTreeToggle
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0

"Tlist
let Tlist_File_Fold_Auto_Close=1
ca tl Tlist

"git-vim
ca gpull GitPull
ca git Git


ca qb Tbbd
ca qq q!
ca w!! w !sudo tee >/dev/null "%"
ca sk call ToggleSketch()
