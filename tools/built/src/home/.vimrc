set encoding=utf-8		" required for YCM
set fileencodings=ucs-bom,utf-8,iso-8859-15,iso-8859-1
set termencoding=utf-8
set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins go here
Plugin 'andy-morris/alex.vim'
Plugin 'andy-morris/happy.vim'
Plugin 'cappyzawa/starlark.vim'
Plugin 'raichoo/haskell-vim'

" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

" User settings here.
let c_minlines = 600
let g:ycm_confirm_extra_conf = 0

let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_before_where = -2
let g:haskell_indent_after_bare_where = 4

set timeout timeoutlen=3000 ttimeoutlen=20
set expandtab

au BufEnter *.[ch],*.cc,*.hs,*.lhs				:set sw=4 ts=4 softtabstop=2
au BufEnter *.yaml,*.yml,*.sh					:set sw=2 ts=2

au BufEnter *.h,*.cc,*.cpp					:set syntax=cpp.doxygen
au BufEnter *.c							:set syntax=c.doxygen
au BufEnter *.y,*.x						:set noexpandtab tw=150

au BufEnter *.BUILD,BUILD.*					:set ft=starlark

au BufEnter *.hs,*.lhs						:set autoindent nocindent smartindent

set autoread
set bs=indent,eol,start " allow backspacing over everything in insert mode
set cursorline
set hlsearch
set rulerformat=%36(%3l:%02c%3V\ %p%%\ +%4o\ 0x%2B\ %3b%)
set wildmenu

set ignorecase
set smartcase

set viminfo='500,\"800
set viminfo+=n~/.local/share/zsh/viminfo

set formatoptions=tcq2
set formatprg="par w78"

set scrolloff=5
set sidescrolloff=3

set backup              " keep a backup file
set backupcopy=auto
set bdir=/tmp
set directory=/var/tmp

set nowrap
set textwidth=80
set terse

nnoremap <C-l> :noh<CR><C-l>
map Q gqap

colorscheme jellybeans
