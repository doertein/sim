set nocompatible              " be iMproved, required
set shell=/bin/bash

" vim-plug config
" auto-installer
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" visual plugins
Plug 'exitface/synthwave.vim'
Plug 'sainnhe/forest-night'
Plug 'cocopon/iceberg.vim'
Plug 'KKPMW/sacredforest-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'nightsense/cosmic_latte'
Plug 'AlessandroYorba/Sierra'
Plug 'itchyny/lightline.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'

" syntax plugins
Plug 'sheerun/vim-polyglot'
Plug 'mustache/vim-mustache-handlebars'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" functional plugins
Plug 'vim-test/vim-test'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'othree/html5.vim'
Plug 'wsdjeg/vim-todo'
Plug 'mattn/emmet-vim'
Plug 'skammer/vim-css-color'
Plug 'airblade/vim-gitgutter'

call plug#end()


""" ============ plugin specific ============

"completor config 
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"mustache config for abbreviations
let g:mustache_abbreviations = 1

let g:ale_linters = {
            \   'javascript': ['eslint'],
            \}

""" ============ testing stuff ============ 
let test#strategy = "vimterminal"


""" ============ colorscheme and lightline ============ 

" lightline and colorscheme configuration. 
set laststatus=2

if strftime('%H') >= 7 && strftime('%H') < 18
    set background=light
    colorscheme cosmic_latte
    let g:lightline = {
                \   'colorscheme': 'cosmic_latte_light',
                \ }
else
    set bg=dark
    colorscheme cosmic_latte
    let g:lightline = {
                \   'colorscheme': 'cosmic_latte_dark',
                \ }
endif

""" ============ syntax specific stuff ============

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype on
filetype plugin on
filetype indent on

" 4 Spaces als Einrueckung
set ts=4
set sw=4
set sts=4
set et

" javascript specific indenting
autocmd FileType javascript setlocal ts=2 sw=2 sts=2 et
autocmd FileType typescript setlocal ts=2 sw=2 sts=2 et


" NERDTree stuff
map <C-n> :NERDTreeToggle<CR>

" set leader to comma
let mapleader = ","

imap <M-Space> <Esc>
nnoremap <Leader>tf :TestFile
nnoremap <Leader>ts :TestSuite
nnoremap <Leader>tn :TestNearest
""" ============

" ignore files for ctrlp
set wildignore+=*/.git/*,*/node_modules/*

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
"check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 <https://github.com/neovim/neovim/pull/2198>
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
" Based on Vim patch 7.4.1770 (`guicolors` option)
" <https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
" <https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
if (has("termguicolors"))
    set termguicolors
endif
