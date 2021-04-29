" vim:set foldmethod=marker:

" vimrcを変更したらVimを再起動するか:source $MYVIMRCを実行してリロードする
" 全ての設定を削除する
"set all&

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

" 端末が広ければ行番号を表示する
if &co > 80
  set number
endif

" 不可視文字を表示する
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" BSキーで改行やインデントを削除する
set backspace=indent,eol,start

" 検索結果をハイライトする
set hlsearch

" 検索をタイプするたびに動的に最初のマッチに移動する
set incsearch

" 開いているファイルのディレクトリに移動する
set autochdir

" ステータスラインを常に表示する
set laststatus=2

" 最後に実行したコマンドをステータスラインに表示する
set showcmd

" ベルを鳴らさない
set belloff=all

" => 見た目 ------------------------------- {{{1
" ダークモード
set background=dark

" カラースキームを設定する
colorscheme pablo

" 行番号の色
highlight LineNr ctermfg=darkyellow
" <= 見た目 ------------------------------- }}}

" 親ディレクトリにあるtagsファイルを再帰的に探す
" apt install ctags
" ctags -R .
set tags=./tags;,tags

" コードを折りたたむ zo:open, zc:close zR:all open, zM: all close
set foldmethod=indent

" 新しいファイルを開くときは折り畳みが開いているようにする
autocmd BufRead * normal zR

" Tabによる自動補完に有効にする
set wildmenu

" 最長マッチまで補完してから自動補完メニューを開く
set wildmode=list:longest,full

" ウィンドウは閉じずにバッファを閉じる
command! Bd :bp | :sp | :bn | :bd

" => Leaderショートカット ------------------------- {{{1
" Leaderキーをバックスラッシュからスペースに変更する
let mapleader = "\<space>"

" Space + n で NERDTreeをトグルする
nnoremap <leader>n :NERDTreeToggle<cr>

" Space + p で CtrlPを呼び出す
"nnoremap <leader>p :CtrlP<cr>

" Space + t で CtrlPTagを呼び出す
"nnoremap <leader>t :CtrlPTag<cr>

" Space + a で カーソル下の単語を:Ack検索
"nnoremap <leader>a :Ack! <c-r><c-w><cr>

" Space + g で カーソルしたの単語を :grep
"nnoremap <leader>g :grep <c-r><c-w> */**<cr>
" <= Leaderショートカット ------------------------- }}}

" => キーマッピング ------------------------------- {{{1
" コントロールキーとhjklで分割されたウィンドウ間をすばやく移動する
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" ESC連打で検索ハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<cr>
" <= キーマッピング ------------------------------- }}}

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

" => プラグイン一覧 ------------------------- {{{1
call plug#begin()
" netrwの見た目を良くする
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Ctrl+pであいまい検索
Plug 'ctrlpvim/ctrlp.vim'

" より良い移動コマンド
Plug 'easymotion/vim-easymotion'

" Vimコマンドの便利なマッピング
Plug 'tpope/vim-unimpaired'

" カラースキームのブラウザ
" :SCROLLCOLOR で呼び出す
Plug 'vim-scripts/ScrollColors'

" 軽量なステータスライン拡張
Plug 'vim-airline/vim-airline'

" GitとVimを統合する
Plug 'tpope/vim-fugitive'

call plug#end()
" <= プラグイン一覧 ------------------------- }}}

" => [NERDTree] 設定 ------------------------- {{{1
" [NERDTree] 起動時にブックマークを表示
let NERDTreeShowBookmarks = 1

" [NERDTree] NERDTreeのウィンドウしか開かれていないときは自動的にとじる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
  \ b:NERDTree.isTabTree()) | q | endif
" <= [NERDTree] 設定 ------------------------- }}}

" => 使っていない設定 ------------------------- {{{1
"set fenc=utf-8
"set nobackup
"set noswapfile
"set autoread
"set hidden
"set number
"set cursorline
"set smartindent
"set visualbell
"set showmatch
"set autoindent
"set softtabstop=0
"set ignorecase
"set smartcase
"set wrapscan
" <= 使っていない設定 ------------------------- }}}

" => Vim チートシート ------------------------- {{{1
"""" Vimの移動コマンド
"" hjkl: 1文字
"" w/W: 次のword/WORDの先頭に移動
"" e/E: 次のword/WORDの末尾に移動
"" b/B: 前のword/WORDの先頭に移動
"" ge/gE: 前のword/WORDの末尾に移動
"" {}: 段落単位
"" t[文字列]: 現在行で文字列を検索して、直前にカーソル移動する。逆方向は T
"" f[文字列]: 現在行で文字列を検索して、その文字にカーソル移動する。逆方向は F
"" H : 現在表示されている一番上の行に移動
"" L : 現在表示されている一番下の行に移動
"" gg : ファイルの先頭に移動する
"" G : ファイルの末尾に移動する

"""" インサートコマンド
"" gi : 最後にインサートモードを抜けた箇所からインサートする
"" cc,S : インデントを保存しつつ行の内容をすべて削除してインサートモードに入る
"" C : インサートモードに入る前にカーソルから右の文字をすべて削除する
"" s : インサートモードに入る前にカーソル下の文字を削除する (数字を付けると数字文文字を削除する)
"" インサートモード中に Ctrl+o で一回だけコマンド実行する

"""" レジスタ操作
"" "ayw : aレジスタにワードをヤンク
"" "ap : aレジスタの内容をペースト
"" "%p : ファイル名をペースト %: ファイル名レジスタ
"" "#p : 最後に開かれたファイル名をペースト #: 最後に開かれたファイル名
"" ".p : 最後に挿入されたテキストをペースト .: 最後に挿入されたテキスト
"" ":p : 最後に実行されたコマンドをペースト : 最後に実行されたコマンド
"" "*p : クリップボードの内容をペースト *: システムのクリップボード
"" インサート中に Ctrl+r でレジスタの内容をペーストする
"" :reg : 全てのレジスタの内容を確認する :reg a b : a, bレジスタの内容を確認する

"""" 囲まれたところの選択
"" vi" : ダブルクォートの中を選択  va" : ダブルクォートも選択
"" vi] : []の中を選択  va] : []も選択
"" vi) : ()の中を選択  va) : ()も選択

"""" タグ移動
"" gd : 変数を宣言している場所に移動
"" gD : グローバスにファイル先頭から探す
"" Ctrl+] : タグの定義場所に移動する
"" Ctrl+t : タグスタックをさかのぼる
"" :ts : タグリスト
"" :tn, :tp : タグを表示する

"""" マーキング
"" m[a-z] : カーソル位置をマークする
"" `[a-z] : マークした位置に戻る

"""" ファイルをまたいで検索する
"" :grep : システムのgrepを使う
"" :vimgrep : Vimのgrepを使う :vimgrep パターン **/*.py **で再帰的に検索する
"" :Ack : 簡単に再帰検索できる :Ack hoge

"""" Quickfix
"" :copen : Quickfixを開く
"" :cclose : Quickfixを閉じる
"" :cn : 次のfixに移動
"" :cp : 前のfixに移動

"""" 折り畳み
"" zo: 展開
"" zc: 折りたたむ
"" zR: 全展開
"" zM: 全部折りたたむ

"""" マクロ
"" q[任意のアルファベット] : 記録開始 (qa)
"" q : 記録停止
"" @[記録したアルファベット] : マクロ再生 (@a)
"" @@ : 直前のマクロ再生を繰り返す

"""" ウィンドウ
"" Ctrl+w o, :onl, :on : 現在のウィンドウ以外のすべてのウィンドウを閉じる
"" Ctrl+w x : 隣のウィンドウと入れ替える
"" Ctrl+w r (R) : 行または列の中にあるすべてのウィンドウを右または下に移動する

"""" ウィンドウリサイズ
"" :resize +N : 現在のウィンドウの高さをN行増加させる
"" :resize -N : 現在のウィンドウの高さをN行減少させる
"" :vertical resize +N : 現在のウィンドウの幅をN列増加させる
"" :vertical resize -N : 現在のウィンドウの幅をN列減少させる

"""" ターミナル
"" Ctrl+w "<レジスタ名> : レジスタの内容を張り付ける  Ctrl+w "" で直前のコメントを入れられる
"" Ctrl+w Ctrl+c : ターミナルを終了する
"" Ctrl+c Ctrl+c : 多いーみなるにCtrl+cを送信する

"""" コマンドラインモード
"" : コマンドラインモードに入る
"" Ctrl+p, Ctrl+n コマンド履歴を移動
"" Ctrl+b, Ctrl+e コマンドラインの先頭、末尾に移動
"" Ctrl+f, Ctrl+c コマンド履歴の編集ウィンドウを開く、閉じる

"""" Visualモード
"" o : 選択範囲の反対側に移動する (したがって、反対側に選択範囲を拡張可能)

"""" 置換モード
"" R : 置換モードに入る

"""" 組み込み補完
"" インサートモードで文字を入力してから Ctrl+n, Ctrl+p で補完
"" インサートモードでCtrl+x, Ctrl+l 行を丸ごと補完
"" インサートモードでCtrl+x, Ctrl+] タグを補完
"" インサートモードでCtrl+x, Ctrl+f ファイル名を補完

"""" vim-unimpairedのコマンド
"" ]b, [b : バッファを順に表示する
"" ]f, [f : 同じディレクトリのファイルをバッファに読み込む
"" ]l, [l : ロケーションリスト
"" ]q, [q : Quickfix
"" ]t, [t : タグ
"" yoc : カーソル行ハイライト

"""" Netrwのコマンド
"" :Vex : 縦分割されたウィンドウでNetrwを開く
"" :Sex : 横分割されたウィンドウでNetrwを開く
"" :Lex : 一番左に最大の高さのウィンドウでNetrwを開く
"" Enter : ファイルまたはディレクトリを開く
"" - : ディレクトリを上がる
"" D : ファイルまたはディレクトリを削除する
"" R : ファイルまたはディレクトリをリネームする

"""" CtrlPのコマンド
"" Ctrl+p : あいまい検索呼び出し
"" ESC : 閉じる
"" Ctrl+j, Ctrl+k : 上下に移動
"" Ctrl+b : バッファ検索
"" Ctrl+f : ファイル検索

"""" EasyMotionのコマンド
"" \\f : 文字を右側に探す \\F : 文字を左側に探す
"" \\w/W : 次のword/WORDの先頭に移動
"" \\e/E : 次のword/WORDの末尾に移動
"" \\b/B : 前のword/WORDの先頭に移動
"" \\ge/gE : 前のword/WORDの末尾に移動
"" \\k/j : 上の行/下の行の先頭に移動
"" \\n/N : 直前の検索結果に基づいて前方/後方の結果に移動

"""" YouCompleteMeのコマンド
"" エンジンは . ピリオドを入力すると自動的に有効になる
"" Ctrl+<space> で手動で有効にもできる

" <= Vim チートシート ------------------------- }}}

