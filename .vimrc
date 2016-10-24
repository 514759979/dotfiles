set nocompatible
set fencs=utf-8,utf-16le,gb18030
set enc=utf-8
set ambiwidth=double
set display=lastline " 不显示@
set nu
set cindent
set backspace=indent,eol,start
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set hlsearch
set mouse=a
set autochdir
set nobackup
set laststatus=2
syntax on
syntax enable
colorscheme elflord
filetype plugin indent on

let c_comment_strings=1 " highlighting strings inside C comments
autocmd FileType c set makeprg=gcc\ -g\ -Wall\ %\ -o\ %:t:r
autocmd FileType cpp set makeprg=g++\ -g\ -std=c++11\ -Wall\ %\ -o\ %:t:r
nnoremap <F2> :set mouse=<cr>:set nonu<cr>
set pastetoggle=<F3>
nnoremap <F4> :set mouse=a<cr>:set nu<cr>
nnoremap <F5> :!./%<cr>
nnoremap <F6> :!o %<cr><cr>
nnoremap <F7> :!./%:t:r<cr>
nnoremap <F9> :w<cr>:make<cr>:cw<cr>
nnoremap <C-a> ggVG
ca qq q!
ca w!! w !sudo tee >/dev/null "%"
map <C-c> :'<,'>w !wrun clip<cr><cr>
nmap k gk
nmap j gj
nmap 0 g0
nmap $ g$
vmap $ g$
vmap 0 g0
vmap k gk
vmap j gj
map <C-j> :tabprevious<cr>
map <C-k> :tabnext<cr>

set statusline=
set statusline +=%1*\ %n\ %*                      "buffer number
set statusline +=%5*%{&ff}%*                      "file format
set statusline +=%3*,%{&fenc!=''?&fenc:&enc}%*    "encoding
set statusline +=%3*%{&bomb?',bom':''}%*          "bom
set statusline +=%3*%Y%*                          "file type
set statusline +=%3*%R%*                          "readonly
set statusline +=%4*\ %<%F%*                      "full path
set statusline +=%2*%m%*                          "modified flag
set statusline +=%1*%=%5l%*                       "current line
set statusline +=%2*/%L%*                         "total lines
set statusline +=%2*\ %p%%\ %*                    "lines %
set statusline +=%1*%4v\ %*                       "virtual column number
set statusline +=%2*0x%04B\ %*                    "character under cursor

"{{{ winmanager
ca nt WMT
"}}}

"{{{ supertab
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'
"}}}

"{{{ vim-plug
ca PlugInit !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'L9'
Plug 'vim-scripts/a.vim'
Plug 'othree/vim-autocomplpop'
Plug 'tsaleh/vim-supertab'
Plug 'KNCheung/vim-winmanager'

call plug#end()            " required
"}}}
