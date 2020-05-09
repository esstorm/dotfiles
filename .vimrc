set nocompatible              " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'bling/vim-airline'
Plugin 'Buffergator'
Plugin 'Markdown'
Plugin 'Markdown-syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'OmniCppComplete'
Plugin 'ctags.vim'
Plugin 'surround.vim'
Plugin 'molokai'
Plugin 'The-NERD-Commenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'farmergreg/vim-lastplace'
"Plugin 'project.vim'
Plugin 'EasyMotion'
"Plugin 'Python-Syntax-Folding'
"Plugin 'snipMate'
"Plugin 'MRU'
"Plugin 'rstacruz/sparkup'
"Plugin 'better-snipmate-snippet'
"Plugin 'html-xml-tag-matcher'
"Plugin 'Matchtag'
" Snippets are separated from the engine. Add this if you want them:
"Plugin 'xolox/vim-session'
call vundle#end()            " required

filetype plugin indent on    " required
filetype plugin on
set encoding=utf-8
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

"Have Vim jump to the last position when reopening a file
if has("autocmd")
	  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	endif

map <leader>n <plug>nerdtreetabstoggle<cr>

let mapleader = ","
cmap w!! w !sudo tee >/dev/null % "This is only really useful for Linux
"installs...
inoremap jj <ESC>
map <C-Left> <ESC>:tabprev<CR>
map <C-Right> <ESC>:tabnext<CR>
map <C-n> <ESC>:tabnew<CR>

vmap <C-c> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u
"map <Insert> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>

nmap <silent> <C-D> :NERDTreeToggle<CR>
nnoremap <silent> <C-L> :noh<CR><C-L>
map <leader>r :NERDTreeFind<cr>
" Airline Hacks
set laststatus=2                              " without this the status line
set ttimeoutlen=50                            " to prevent delay when
"let g:airline#extensions#tabline#enabled = 1  " it is disabled by default,

"let g:airline_powerline_fonts=1               " using patched Inconsolata
"let g:airline_theme='powerlineish'            " favourite theme
"let g:rehash256=1

"" " Colorscheme
let g:molokai_original=1
colorscheme molokai

let g:NERDTreeHijackNetrw=0
let g:session_autoload = 'no'

set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
"set guifont=Inconsolata\ for\ Powerline\ Medium\ 12
set expandtab
set softtabstop=2
set shiftwidth=2
set laststatus=2
set number
syntax on
