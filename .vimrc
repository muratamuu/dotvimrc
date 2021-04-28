" vimrcを変更したらVimを再起動するか:source $MYVIMRCを実行してリロードする
" 全ての設定を削除する
set all&

" vi互換モードをOFFにする
set nocompatible

" シンタックスハイライトを有効化
syntax on

" ファイルタイプに基づいたインデントを有効化
filetype plugin indent on

" タブをスペースに展開する
set expandtab

" タブのスペース数を2にする
set tabstop=2

" 改行やCtrl-D,Tでインデントするスペース数をtabstopと同じにする
set shiftwidth=0

" 不可視文字を表示する
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" BSキーで改行やインデントを削除する
set backspace=indent,eol,start

" 検索結果をハイライトする
set hlsearch

" 開いているファイルのディレクトリに移動する
set autochdir

" ステータスラインを常に表示する
set laststatus=2

" ベルを鳴らさない
set vb t_vb=

" カラースキームを設定する
"colorscheme murphy

" ウィンドウは閉じずにバッファを閉じる
command! Bd :bp | :sp | :bn | :bd

" コントロールキーとhjklで分割されたウィンドウ間をすばやく移動する
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" コードを折りたたむ zo:open, zc:close zR:all open, zM: all close
set foldmethod=indent

" 新しいファイルを開くときは折り畳みが開いているようにする
autocmd BufRead * normal zR

" Tabによる自動補完に有効にする
set wildmenu

" 最長マッチまで補完してから自動補完メニューを開く
set wildmode=list:longest,full

" swapファイルを元のファイルのディレクトリではなくHOME下に置く
if !isdirectory(expand("$HOME/.vim/swap"))
  call mkdir(expand("$HOME/.vim/swap"), "p")
endif
set directory=$HOME/.vim/swap//

" すべてのファイルについて永続アンドゥを有効にする
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
  call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

" 手動で管理するプラグインのインストール方法
" GitHubでプラグインを見つけ以下の様にインストールする(下記はnerdtreeの例)
" git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/plugins/start/nerdtree
" プラグイン用のディレクトリを作成する
if !isdirectory(expand("$HOME/.vim/pack/plugins/start/"))
  call mkdir(expand("$HOME/.vim/pack/plugins/start/"), "p")
endif
" すべてのプラグインをロードする
packloadall
" すべてのプラグイン用にヘルプファイルをロードする
silent! helptags ALL

" vim-plugでプラグインを管理する
" :PlugInstallコマンドでプラグインをインストールしてください
" :PlugUpdateコマンドですべてのプラグインをアップデートしてください
" :PlugCleanでvimrcから削除したプラグインをファイルシステムから削除します
" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
" vim-plugのヘルプを見れるようにする
Plug 'junegunn/vim-plug'
" netrwの見た目を良くする
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" -でnetrwを開く
Plug 'tpope/vim-vinegar'
" Ctrl+pであいまい検索
Plug 'ctrlpvim/ctrlp.vim'
" act統合
Plug 'mileszs/ack.vim'
" より良い移動コマンド
Plug 'easymotion/vim-easymotion'
" 気を散らさない執筆
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

" [NERDTree] 起動時にブックマークを表示
let NERDTreeShowBookmarks = 1

" [NERDTree] Vim起動時にNERDTreeを開く
autocmd VimEnter * NERDTree

" [NERDTree] NERDTreeのウィンドウしか開かれていないときは自動的にとじる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
  \ b:NERDTree.isTabTree()) | q | endif




"""" 使っていない設定
"set fenc=utf-8
"set nobackup
"set noswapfile
"set autoread
"set hidden
"set showcmd
"set number
"set cursorline
"set smartindent
"set visualbell
"set showmatch
"set autoindent
"set softtabstop=0
"set ignorecase
"set smartcase
"set incsearch
"set wrapscan
"nmap <Esc><Esc> :nohlsearch<CR><Esc>

"""" Vimのメモ
"" Vimの移動コマンド
"" hjkl: 1文字
"" web: word単位, WEB: WORD単位
"" {}: 段落単位
