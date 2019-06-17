﻿if has('unix')
    let $MYVIMDIR = expand('$HOME/.config/nvim')
elseif has('win32')
    let $MYVIMDIR = expand('$LOCALAPPDATA/nvim')
    let $HOME = expand('$HOME')
endif

call plug#begin(expand('$MYVIMDIR/plugged'))

Plug 'airblade/vim-gitgutter'
Plug 'arrufat/vala.vim'
Plug 'leafgarland/typescript-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-anzu'
Plug 'reedes/vim-colors-pencil'
Plug 'rust-lang/rust.vim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ebnf.vim'
Plug 'w0rp/ale'

call plug#end()

nnoremap <silent> <Esc> :set hls!<Enter>
nnoremap / :set hls<Enter>/
nnoremap ? :set hls<Enter>?
nmap <silent> n <Plug>(anzu-n-with-echo)zv:set hls<Enter>
nmap <silent> N <Plug>(anzu-N-with-echo)zv:set hls<Enter>
nmap <silent> * <Plug>(anzu-star-with-echo)zv:set hls<Enter>
nmap <silent> # <Plug>(anzu-sharp-with-echo)zv:set hls<Enter>

nnoremap <silent> <Space>w :set wrap!<Enter>

noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k
nnoremap Y y$

set number
set background=dark
set scrolloff=9999
set sidescrolloff=9999
set list
set listchars=eol:⏎,tab:>\ ,trail:␣,extends:»,precedes:»
set ignorecase
set smartcase
set gdefault
set breakindent
set backupcopy=yes
set termguicolors
set splitright
set hidden
set undofile
set backup
set backupdir=~/.local/share/nvim/backup
set omnifunc=ale#completion#OmniFunc

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

"let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'c': ['clangd'],
            \ 'cpp': ['clangd'],
            \ 'python': ['pyls'],
            \ 'rust': ['rls'],
            \ 'typescript': ['tsserver'],
            \ }
let g:ale_fixers = {
            \ 'c': ['clang-format'],
            \ 'cpp': ['clang-format'],
            \ 'css': ['prettier'],
            \ 'go': ['gofmt'],
            \ 'html': ['prettier'],
            \ 'javascript': ['prettier'],
            \ 'json': ['prettier'],
            \ 'python': ['yapf'],
            \ 'rust': ['rustfmt'],
            \ 'sh': ['shfmt'],
            \ 'typescript': ['prettier'],
            \ }
let g:ale_fix_on_save = 1

command! -nargs=+ -complete=file TabEdit :call TabEdit(<f-args>)
function! TabEdit(...) abort
   for l:arg in a:000
       for l:path in glob(l:arg, 0, 1)
           if isdirectory(l:path)
                continue
            endif
           execute 'tabedit' l:path
       endfor
   endfor
endfunction

augroup vimrc
	autocmd!
	autocmd BufWritePre * let &l:backupext = '-' . substitute(expand("%:p"), "/", "%", "g") . '-' . strftime("%y%m%d%H%M%S")
augroup END

colorscheme pencil
" vim: set ts=4 sw=4 et:
