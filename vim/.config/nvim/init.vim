" Encoding
scriptencoding utf-8
set encoding=utf-8

" Don't try to be vi compatible
set nocompatible
set path+=**
set wildmenu

" Install vimplug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
call plug#end()

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Pick a leader key
let mapleader = ","

" Show line numbers
set number
set relativenumber

" Enable huge cursor crosshair
set cursorline
set cursorcolumn

" Enable mouse interaction
set mouse=a

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Whitespace
set nowrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Show opening bracket right after closing
set showmatch

" Auto-save
set autowrite

" Searching
set hlsearch
set incsearch
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Make shift insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Setup dictionary
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

" Setup undodir
set undodir=~/.config/vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Disable vim de/increment for octal numbers, who uses that anyway
set nrformats-=octal

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬,extends:>,precedes:<,space:·
set list

" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Enable verilog navigation
nnoremap <leader>u :VerilogGotoInstanceStart<CR>
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>o :VerilogFollowPort<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Enable 24bit color if possible
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8d = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set theme
set background=light
colorscheme solarized8
let g:solarized_old_cursor_style = 1
let g:solarized_visibility = "low"



""""""""
" TODO "
""""""""

" Generate tag file
" Valid version:
"    Universal Ctags 0.0.0(3f4203d), Copyright (C) 2015 Universal Ctags Team
"    Universal Ctags is derived from Exuberant Ctags.
"    Exuberant Ctags 5.8, Copyright (C) 1996-2009 Darren Hiebert
"      Compiled: Jan 27 2020, 18:20:04
"      URL: https://ctags.io/
"      Optional compiled features: +wildcards, +regex, +iconv, +option-directory, +xpath, +packcc
" TODO: Change this so it uses an external script or something to make this more portable
command! TagsWS execute "!find -L $VC_WORKSPACE/ip/*/{rtl,sim} -regex '.*\.svh?' -exec ctags --language-force=systemverilog --tag-relative=yes --extras=+q --fields=+i {} +"
command! Tags execute "!find -L -regex '.*\.svh?' -exec ctags --language-force=systemverilog --tag-relative=yes --extras=+q --fields=+i {} +"
nnoremap <F4> :Tags<CR>
nnoremap <S-F4> :TagsWS<CR>

" easier diff:
"   - Shift Down: next diff
"   - Shift Up: last diff
"   - Shift Left: merge left
"   - Shift Right: merge right
" TODO: Improve 3way diff
if &diff
    let g:diffUndoQueue = []
    function! DiffUndo()
      let last = remove(g:diffUndoQueue, -1)
      wincmd h
      if last == "Right"
        wincmd w
        normal u
        wincmd w
      else
        normal u
      endif
      diffupdate
    endfunction
    function! DiffMergeRight()
      wincmd h
      wincmd w
      normal do
      wincmd w
      call add(g:diffUndoQueue, "Right")
    endfunction
    function! DiffMergeLeft()
      wincmd h
      normal do
      call add(g:diffUndoQueue, "Left")
    endfunction
    nnoremap <S-Down> ]c
    nnoremap <S-Up> [c
    nnoremap <S-Right> :call DiffMergeRight()<cr>
    nnoremap <S-Left> :call DiffMergeLeft()<cr>
    nnoremap U :call DiffUndo()<cr>
    set nocursorline
    set nocursorcolumn
    set diffopt+=iwhite
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

