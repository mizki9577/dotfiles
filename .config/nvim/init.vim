﻿if has('unix')
    let $MYVIMDIR = expand('$HOME/.config/nvim')
elseif has('win32')
    let $MYVIMDIR = expand('$LOCALAPPDATA/nvim')
    let $HOME = expand('$HOME')
endif

call plug#begin(expand('$MYVIMDIR/plugged'))

Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'install.sh',
            \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
"Plug 'zchee/deoplete-jedi'

Plug 'Rip-Rip/clang_complete'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-anzu'
Plug 'reedes/vim-colors-pencil'
Plug 'rust-lang/rust.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
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

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
nnoremap Y y$

nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<Enter>

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

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'c': ['clangd'],
            \ 'cpp': ['clangd'],
            \ 'javascript': ['flow-language-server', '--stdio'],
            \ 'python': ['pyls'],
            \ }
let g:deoplete#enable_at_startup = 1
let g:clang_library_path = '/usr/lib/libclang.so'

let g:ale_linters = {
            \ 'cpp': ['clang'],
            \ 'html': ['tidy'],
            \ }
let g:ale_fixers = {
            \ 'css': ['prettier'],
            \ 'go': ['gofmt'],
            \ 'javascript': ['prettier'],
            \ 'json': ['prettier'],
            \ 'python': ['yapf'],
            \ 'sh': ['shfmt'],
            \ 'rust': ['rustfmt'],
            \ }
let g:ale_fix_on_save = 1


" LSP でフォーマットをかける
"augroup format
"    autocmd!
"    autocmd BufWritePre * silent! call LanguageClient#textDocument_rangeFormatting_sync()
"augroup END

command! -nargs=+ -complete=file TabEdit :call TabEdit(<f-args>)
function! TabEdit(...) abort
   for l:arg in a:000
       for l:filename in glob(l:arg, 0, 1)
           execute 'tabedit' l:filename
       endfor
   endfor
endfunction

colorscheme pencil
" vim: set ts=4 sw=4 et:
