set encoding=utf-8		" required for YCM
set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins go here
Plugin 'cappyzawa/starlark.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'raichoo/haskell-vim'
Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

" User settings here.
let g:ycm_confirm_extra_conf = 0

set ttimeoutlen=10
set expandtab

au BufEnter *.[ch],*.hs						:set sw=4 ts=4
au BufEnter *.yaml,*.yml,*.sh					:set sw=2 ts=2

au BufEnter *.h,*.cc,*.cpp					:set syntax=cpp.doxygen
au BufEnter *.c							:set syntax=c.doxygen
au BufEnter *.y							:set syntax=haskell noexpandtab

au BufEnter *.hs						:set autoindent nocindent smartindent

set nowrap
set viminfo='500,\"800
set viminfo+=n~/.local/share/zsh/viminfo

nnoremap <C-l> :noh<CR><C-l>
