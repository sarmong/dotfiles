
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc


syntax on
set noerrorbells
set number
set relativenumber
set ruler

set expandtab
set smartindent
set smarttab
set shiftwidth=2
set tabstop=2

set incsearch

call plug#begin()

Plug 'morhetz/gruvbox'

call plug#end()


