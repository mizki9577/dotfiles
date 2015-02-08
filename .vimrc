﻿" .vimrc

set encoding=utf-8
if has('unix')
	let $MYVIMDIR = expand('$HOME/.vim')
elseif has('win32')
	let $MYVIMDIR = expand('$HOME/vimfiles')
endif

" NeoBundle {{{1
if has('vim_starting')
	setglobal runtimepath+=$MYVIMDIR/bundle/neobundle.vim
endif
call neobundle#begin(expand($MYVIMDIR . '/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim', { 'depends' : [ 'Shougo/vimproc' ] }
NeoBundle 'Shougo/vimproc', { 'build' : {
	\ 'unix' : 'make -f make_unix.mak',
\}}

" Global plugins {{{2
NeoBundle 'Shougo/neocomplete', { 'depends' : [ 'Shougo/vimproc' ] }
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'mattn/gist-vim', { 'depends' : [ 'mattn/webapi-vim' ] }
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'thinca/vim-quickrun', { 'depends' : [ 'Shougo/vimproc' ] }
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/restart.vim'
NeoBundle 'ujihisa/quicklearn'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'JuliaLang/julia-vim'

" Unite sources {{{2
NeoBundle 'Shougo/unite-outline', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'mattn/unite-gist', { 'depends' : [ 'Shougo/unite.vim', 'mattn/gist-vim' ] }
NeoBundle 'thinca/vim-unite-history', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'ujihisa/unite-colorscheme', { 'depends' : [ 'Shougo/unite.vim' ] }

" Lazy load plugins {{{2
NeoBundleLazy 'osyo-manga/vim-marching', { 'autoload' : { 'filetypes': [ 'c', 'cpp' ] } }
NeoBundleLazy 'osyo-manga/vim-snowdrop', { 'autoload' : { 'filetypes': [ 'c', 'cpp' ] } }
NeoBundleLazy 'othree/html5.vim', { 'autoload' : { 'filetypes' : [ 'html' ] } }
NeoBundleLazy 'davidhalter/jedi-vim'
NeoBundleLazy 'nvie/vim-flake8'

" Color Schemes {{{2
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/dw_colors'
" }}}

" Plugin settings {{{2
" neocomplete {{{3
if neobundle#tap('neocomplete')
	function! neobundle#hooks.on_source(bundle)
		" neocomplete 有効
		let g:neocomplete#enable_at_startup = 1

		" データディレクトリ
		let g:neocomplete#data_directory = $MYVIMDIR . '/misc/neocomplete'

		" 'iminsert' が 非0 のときに自動補完をロック
		let g:neocomplete#lock_iminsert = 1

		if !exists('g:neocomplete#force_omni_input_patterns')
			let g:neocomplete#force_omni_input_patterns = {}
		endif
		let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
		let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
		let g:neocomplete#force_omni_input_patterns.cs = '.*[^=\);]'
	endfunction
	call neobundle#untap()
endif

" jedi.vim {{{3
if neobundle#tap('jedi.vim')
	call neobundle#config({
		\ 'autoload': {
			\ 'filetype': ['python']
		\ }
	\})
	function! neobundle#hooks.on_source(bundle)
		let g:jedi#completions_enabled = 0
		let g:jedi#auto_vim_configuration = 0
		let g:jedi#force_py_version = 3
		autocmd FileType python setlocal omnifunc=jedi#completions
	endfunction
	call neobundle#untap()
endif

" vim-flake8 {{{3
if neobundle#tap('vim-flake8')
	call neobundle#config({
		\ 'autoload': {
			\ 'filetypes' : [ 'python' ]
		\ },
		\ 'build': {
			\ 'unix': 'pip install --user --upgrade flake8',
		\}
	\})
	call neobundle#untap()
endif

" }}}

let g:ref_cache_dir = $MYVIMDIR . '/misc/vim_ref_cache'
let g:unite_data_directory = $MYVIMDIR . '/misc/unite'
call neobundle#end()

" Options {{{1
	" UI {{{2
		" フォント
		if has('x11')
			set guifont=M+\ 1mn\ regular\ 10
		elseif has('gui_win32')
			set guifont=M+\ 1mn\ regular:h10:cSHIFTJIS
		endif

		" GUI オプションはだいたい無効
		" icM になるはず
		set guioptions&
		set go-=a go-=e go-=g go-=m go-=r go-=L go-=t go-=T
		set go+=c go+=M

		" UI の区切り部品に使われる文字
		set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:\ ,diff:\ 

		" ステータス行を常に表示する
		set laststatus=2

		" 見えない文字の可視化
		set list	" local
		set listchars=eol:⏎,tab:>\ ,trail:␣,extends:»,precedes:«
		
		" 行番号を表示
		set number	" local

		" ルーラを表示
		set ruler

		" 短縮表示するメッセージのリスト
		" a : ファイル状態の短縮表示
		" I : 起動時のウェルカムメッセージ省略
		" s : ?まで検索したので?に戻ります (vim-anzu が echo するので)
		set shortmess&
		set shm+=a shm-=f shm-=i shm-=l shm-=n shm-=x shm-=o shm-=O shm-=t shm-=T shm+=I shm+=s

		" 折り返された行の先頭に表示する文字列
		set showbreak=»

		" 折り返された行の行頭のインデントを合わせる
		set breakindent

		" breakindent が適用されたとき, showbreak の文字を折り返された行頭に表示する
		set breakindentopt=sbr

		" 未解決コマンドを表示する
		set showcmd

		" タブバーを常に表示する
		set showtabline=2

		" 折り返された見掛け上の1行をウィンドウの最後の行でも表示する
		set display=lastline
	" 書式系 {{{2
		" ステータス行の書式
		set statusline&	" いつかやる
		" ルーラの書式
		set rulerformat&	" いつかやる
		" タブバーの書式
		set tabline&	" いつかやる
		" タイトルバーの書式
		set titlestring& "いつかやる
	" i18n {{{2
		" 迷ったら半角
		set ambiwidth=single

		" 想定される文字エンコーディングのリスト
		set fileencodings=ucs-bom,utf-8,cp932,euc-jp

		" なんかよくわからんけどSKK動く
		set iminsert=2
	" Backup, Session, View, Undo, Swap {{{2
		" バックアップを有効化
		set backup

		" 永続的アンドゥ履歴を有効
		set undofile	" local
		
		" バックアップの属性維持
		set backupcopy=yes

		" バックアップの保存先
		set backupdir=$MYVIMDIR/backup

		" アンドゥファイルの保存先
		set undodir=$MYVIMDIR/undo

		" ビューの保存先
		set viewdir=$MYVIMDIR/view

		" スワップの保存先
		set directory=./,$MYVIMDIR/swap
	" キー無効化 {{{2
		" コマンドラインウィンドウ
		set cedit=

		" 行末から行頭に移動
		set whichwrap=

		" Alt メニュー
		set winaltkeys=no

		" マウス
		set mouse=
	" Search / Replace {{{2
		" 置換フラグ 'g' の効果を反転させる
		set gdefault

		" 起動時はハイライト無効
		set nohlsearch

		" 大文字と小文字を区別しない
		set ignorecase

		" インクリメンタルサーチ
		set incsearch

		" 新しい正規表現エンジンを使う
		set regexpengine=2

		" 大文字が含まれるときは大文字を区別する
		set smartcase
	" コマンドライン {{{2
		" コマンドライン補完の拡張モード
		set wildmenu

		" コマンドライン補完のタブキーの挙動
		set wildmode=longest,full
	" Scrolling {{{2
		" スクロール同期のオプション
		set scrollopt=ver,hor,jump
		" 水平スクロールも1文字単位で行う
		set sidescroll=1
	" }}}
	" クリップボード
	set clipboard=

	" diff モードのオプション
	set diffopt=filler,context:5,vertical

	" コマンド履歴の数
	set history=100

	" 行連結の空白は常に1個
	set nojoinspaces

	" <C-a> や <C-x> で増減させる文字の種類
	set nrformats=alpha,octal,hex

	" 行変更報告は必ずしてほしい
	set report=0

	" インデントを 'shiftwidth' の倍数の丸める
	set shiftround

	" 賢いタブ
	set smarttab

	" 新しいウィンドウは下に
	set splitbelow

	" 新しいウィンドウは左に
	set nosplitright

	" ジャンプ系コマンドで空白文字でもそこにジャンプする
	set nostartofline

	" 矩形選択でタブの内側も移動できる
	set virtualedit=block

	" Terminal
	set t_Co=256

	" 補完オプション
	set completeopt=menu,menuone,longest,preview
" Completion {{{1
	" for marching.vim {{{2
	let g:marching_enable_neocomplete = 1
	let g:marching#clang_command#options = {
	\	'cpp' : '-std=c++1z'
	\}

	" for OmniSharp {{{2
	let g:acp_enableAtStartup = 0
" Auto Commands {{{1
augroup vimrc
	autocmd!
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	autocmd FileType cpp call s:cpp()
	autocmd FileType python call s:python()

	" 世代バックアップ。バックアップファイルの拡張子を日付にすることで上書きを回避する
	autocmd BufWritePre * let &l:backupext = '-' . substitute(expand("%:p"), "/", "%", "g") . '-' . strftime("%y%m%d%H%M%S")

	" ウィンドウを切り替えたときに 'cursorline' を切り替える
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END
" Mapping {{{1
" Unite
nnoremap <Space><Space> :Unite<Space>
nnoremap <silent> <Space><Enter> :Unite source<Enter>

" Edit .vimrc
nnoremap <silent> <Space><BS> :tabe $MYVIMRC<Enter>

" カーソル移動に gj を使用する
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k

" ハイライトのトグル
nnoremap <silent> <Esc> <Esc>:setlocal hlsearch!<Enter>

" 検索開始時に 'hlsearch' を入
nnoremap / :setlocal hlsearch<Enter>/
nnoremap ? :setlocal hlsearch<Enter>?

" anzu
nmap <silent> n <Plug>(anzu-n-with-echo)zv:setlocal hlsearch<Enter>
nmap <silent> N <Plug>(anzu-N-with-echo)zv:setlocal hlsearch<Enter>
nmap <silent> * <Plug>(anzu-star-with-echo)zv:setlocal hlsearch<Enter>
nmap <silent> # <Plug>(anzu-sharp-with-echo)zv:setlocal hlsearch<Enter>

" 行番号相対表示のトグル
nnoremap <expr> <silent> <Space>n ToggleRelativeNumber()
function! ToggleRelativeNumber()
	" 'number' が切のときは何もしない
	if &l:number
		setlocal relativenumber!
	endif
endfunction

" 行番号表示のトグル
nnoremap <expr> <silent> <Space>N ToggleShowNumber()
function! ToggleShowNumber()
	setlocal norelativenumber
	if &l:number || &l:relativenumber
		setlocal nonumber
	else
		setlocal number
	endif
endfunction

" 'colorcolumn' に追加
nnoremap <expr> <silent> <Space>c ToggleColorColumn()
function! ToggleColorColumn()
	" a:column を 'colorcolumn' に追加または削除
	let l:column = virtcol('.')
	let l:columnlist = split(&l:colorcolumn, ",")
	let l:index = index(l:columnlist, string(l:column))
	if l:index == -1
		call add(l:columnlist, l:column)
	else
		call remove(l:columnlist, l:index)
	endif
	let &l:colorcolumn = join(l:columnlist, ',')
endfunction

" 'colorcolumn' をクリア
nnoremap <silent> <Space>C :setlocal colorcolumn=<Enter>

" スクロール同期の切り換え
nnoremap <silent> <Space>b :setlocal cursorbind!<Enter>

" 'wrap' の切り換え
nnoremap <expr> <silent> <Space>w ToggleWrap()
function! ToggleWrap()
	if &l:wrap
		if stridx(&l:cpoptions, 'n') == -1
			setlocal cpoptions+=n
			setlocal nowrap
		else
			setlocal cpoptions-=n
		endif
	else
		setlocal wrap
	endif
endfunction

" 'ambiwidth' の切り換え
nnoremap <expr> <silent> <Space>a ToggleAmbiguousWidth()
function! ToggleAmbiguousWidth()
	if &l:ambiwidth == 'single'
		setlocal ambiwidth=double
	else
		setlocal ambiwidth=single
	endif
endfunction

" Gundo
nnoremap <silent> <Space>u :GundoToggle<Enter>

" VimFiler
nnoremap <silent> <Space>f :VimFilerSplit -winwidth=32 -toggle -explorer<Enter>

" スクロールオフセットの切り替え
nnoremap <expr> <silent> <Space>s ToggleScrollOffset()
function! ToggleScrollOffset()
	let &l:scrolloff = &l:scrolloff ? 0 : 9999
	let &l:sidescrolloff = &l:sidescrolloff ? 0 : 9999
endfunction
set scrolloff=9999
set sidescrolloff=9999

" チルダコマンド上書き {{{2
nnoremap <silent> ~ :call Tilde()<CR>
function! Tilde()
	let l:from = '!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
	let l:to   = '=''#$%|"[]/_,+.\0123456789:;(!)?@abcdefghijklmnopqrstuvwxyz{*}^-`ABCDEFGHIJKLMNOPQRSTUVWXYZ<&>~'

	let l:current_line = getline('.')
	let l:current_line_num = line('.')
	let l:current_column_num = col('.')
	let l:cursor_char = matchstr(l:current_line, '.', l:current_column_num - 1)
	let l:charbytes = strlen(l:cursor_char)
	let l:split_index = match(l:current_line, '.', l:current_column_num - 1)
	let l:head = l:current_line[: l:split_index - 1]
	let l:tail = l:current_line[l:split_index + l:charbytes :]
	let l:newchar = tr(l:cursor_char, l:from, l:to)

	call setline(line('.'), l:head . l:newchar . l:tail)
	"call cursor(l:current_line_num, l:current_column_num + l:charbytes)
endfunction
" }}}
" Filetype {{{1
" C++ {{{2
function! s:cpp()
	setlocal ts=4 sw=4 et
	setlocal matchpairs+=<:>
endfunction

" Python {{{2
function! s:python()
	setlocal ts=4 sw=4 et
endfunction

" }}}

colorscheme dw_red
syntax on
filetype plugin indent on

" vim: fdm=marker ts=4 sw=4
