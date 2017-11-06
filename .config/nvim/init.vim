if has('unix')
    let $MYVIMDIR = expand('$HOME/.config/nvim')
elseif has('win32')
    let $MYVIMDIR = expand('$LOCALAPPDATA/nvim')
endif

call plug#begin(expand('$MYVIMDIR/plugged'))

Plug 'reedes/vim-colors-pencil'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Rip-Rip/clang_complete'

call plug#end()

set number
set background=dark
set scrolloff=9999
set sidescrolloff=9999
set list
set listchars=eol:⏎,tab:>\ ,trail:␣,extends:»,precedes:»

let g:deoplete#enable_at_startup = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:clang_library_path='/usr/lib/libclang.so'

let g:ale_linters = {
	\ 'cpp': ['clang'],
\}

colorscheme pencil
