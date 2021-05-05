" vim:set foldmethod=marker:

" vimrcを変更したらVimを再起動するか:source % or $MYVIMRC を実行してリロードする
" 全ての設定を削除する
"set all&

" vi互換モードをOFFにする
" おまじないと化しているはずだがこれがないと foldmethod marker ができない
set nocompatible

" => 必要なソフトや初期設定 {{{1

" sudo apt install fzf ファジーファインダ
" sudo apt install bat ripgrep ファジーファインダで高度なgrepを使う
" Microsoft IME <ESC>でIME OFFにするように設定しておく
" WSLターミナルでペーストのバインドを<Ctrl+v>から<Ctrl+Shift+v>に変えておく

" => coc.nvim でインストール {{{2

" :CocInstall coc-json, coc-vetur, coc-prettier, coc-eslint, coc-rls

" <= coc.nvim でインストール }}}

" <= 必要なソフト }}}

" => Pre-load {{{1

" ファイルタイプに基づいたインデントを有効化
filetype plugin indent on

" => 手動プラグイン管理 {{{2
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
"<= 手動プラグイン管理 }}}

" .vimrc保存時の自動読み込み
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" <= Pre-load }}}

" => vim-plug プラグイン一覧 {{{1

" :PlugInstallコマンドでプラグインをインストール
" :PlugUpdateコマンドですべてのプラグインをアップデート
" :PlugCleanでvimrcから削除したプラグインをファイルシステムから削除

" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" ファイルツリー
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'

" ファイルツリー
Plug 'lambdalisue/fern.vim'

" ファイルツリーにgitの差分を表示する
Plug 'lambdalisue/fern-git-status.vim'

" ファイルツリーにフォントを表示する
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" ファジーファインダ
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Ctrl+pであいまい検索
" ファジーファインダはfzfを使うのでこちらは削除
"Plug 'ctrlpvim/ctrlp.vim'

" より良い移動コマンド
Plug 'easymotion/vim-easymotion'

" Vimコマンドの便利なマッピング
Plug 'tpope/vim-unimpaired'

" カラースキームのブラウザ
" :SCROLLCOLOR で呼び出す
Plug 'vim-scripts/ScrollColors'

" 軽量なステータスライン拡張
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Git統合
Plug 'tpope/vim-fugitive'

" Git統合
Plug 'jreybert/vimagit'

" Gitの追加/削除/変更行を行番号の左に表示する
Plug 'airblade/vim-gitgutter'

" 複数行をまとめてコメントアウト
" gc コマンド
Plug 'tpope/vim-commentary'

" 括弧やクォートやタグを表すテキストオブジェクトを追加し括弧の変換をやりやすくする
" cs"' とか ds[ とか ds} は(with スペース)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " . で繰り返す

" 編集中のスクリプトをすぐに実行する
" <Leader> + r で実行
Plug 'thinca/vim-quickrun'

" ウィンドウの分割サイズを簡単に調整する
" Ctrl+e でリサイズ開始、hjklで調整、Enterで確定
Plug 'simeji/winresizer'

" チートシートを別ペインで表示する
" :Cheatで表示切替
Plug 'reireias/vim-cheatsheet'

" markdownプレビュー
" :PrevimOpen
Plug 'previm/previm'

" markdownのテーブルを書きやすくする
" TableModeToggleでon/offする
Plug 'dhruvasagar/vim-table-mode'

" ソースコード整形ツールPrettierを呼び出す
" <Leader> + p または :Prettier で実行する
" coc-prettierを使うのでこちらは無効
"Plug 'prettier/vim-prettier', {
"  \ 'do': 'npm install',
"  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" .editorconfigの設定でフォーマットする
Plug 'editorconfig/editorconfig'

" 末尾のスペースを可視化
" :FixWhitespaceで削除もできる
Plug 'bronson/vim-trailing-whitespace'

" インデントを可視化
Plug 'Yggdroot/indentLine'

" htmlやxmlのタグを入力すると自動で閉じるタグを入力する
Plug 'alvan/vim-closetag'

" LSPクライアント
" :CocInstall <extension>, :CocUnInstall <extension>
" extension: coc-json, coc-vetur
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" VSCode風のカラースキーム
Plug 'tomasiser/vim-code-dark'

" 非同期Linter
Plug 'w0rp/ale'

" バッファ削除時にウィンドウ分割を維持
Plug 'qpkorr/vim-bufkill'

" ファイルの操作
" :Delete, :Chmod, :Rename, :Move
Plug 'tpope/vim-eunuch'

call plug#end()

" <= vim-plug プラグイン一覧 }}}

" => 編集 {{{1

" => インデント {{{2

" 何個分のスペースで1つのタブとしてカウントするか
" epandtabがオフのときは挿入スペース数がこの値になるとタブに変換される
set tabstop=2

" <Tab>を押したとき、何個分のスペースを挿入するか
" 0: softtabstopの機能オフ,  -1: shiftwidthの値が使われる
set softtabstop=0

" インデントしたとき、スペース何個分のインデントをさせるか
" Enter改行時、ノーマルモードの<<, >>、インサートモードのCtrl-D, Ctrl-T
" 0: tabstopの値が使われる
set shiftwidth=0

" ソフトタブ(タブをスペースに展開すること)を有効にする
set expandtab

" 改行時に前の行のインデントと同じ幅でインデントを挿入する
set autoindent

" 行の先頭でタブを入力するとshiftwidthで定義されたインデントが挿入される
set smarttab

" <= インデント }}}

" => ファイル保存 {{{2

" スワップファイルを元のファイルのディレクトリではなくHOME下に置く
if !isdirectory(expand("$HOME/.vim/swap"))
  call mkdir(expand("$HOME/.vim/swap"), "p")
endif
set directory=$HOME/.vim/swap//

" スワップファイルを作らない
set noswapfile

" 自動バックアップファイルを作らない
set nobackup

" ファイルの上書き前にバックアップを作る
" nobackupの場合、このバックアップは上書き成功時に削除される
set writebackup

" 保存されていないファイルがあるときは終了前に保存確認
set confirm

" 保存されていないファイルがあるときでも別のファイルを開ける
set hidden

" 外部でファイルに変更があった場合は読み直す
set autoread

" <= ファイル保存 }}}

" すべてのファイルについて永続アンドゥを有効にする
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
  call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

" 開いているファイルのディレクトリに移動する
" タグジャンプとかで移動しない方が良い
" :lcd (or :cd) %:h でファイルのディレクトリに移動 :pwdで確認
"set autochdir

" Tabによる自動補完に有効にする
set wildmenu

" 最長マッチまで補完してから自動補完メニューを開く
set wildmode=list:longest,full

" BSキーで改行やインデントを削除する
" indent: autoindentを超えてバックスペースを働かせる
" eol: 改行を超えてバックスペースを働かせる (行を連結する)
" start: 挿入区間の初めでバックスペースを働かせる
set backspace=indent,eol,start

" 閉じ括弧が入力されたとき、対応する開き括弧にわずかの間ジャンプする
set showmatch

" ヤンクした内容をクリップボードに入れる
" :versionで+clipboardでコンパイルされていないので動かない
"set clipboard=unnamedplus

" 新しいウィンドウを下に開く
set splitbelow

" 新しいウィンドウを右に開く
set splitright

" 検索にマッチした行以外を折りたたむ機能はOFF
set nofoldenable

" <= 編集 }}}

" => 見た目 {{{1

" シンタックスハイライトを有効化
" enable: 現在の色設定を変更しない
" on: 現在の設定を履きしてデフォルトの色を設定
syntax on

" 端末が広ければ行番号を表示する
if &co > 80
  set number
endif

" 不可視文字を表示する
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" ダークモード
set background=dark

" カラースキーム
"colorscheme pablo
colorscheme codedark

" 行番号の色
highlight LineNr ctermfg=darkyellow

" カーソル行をハイライトする
set cursorline

" ステータスラインを常に表示する
set laststatus=2

" 最後に実行したコマンドをステータスラインに表示する
set showcmd

" ベルを鳴らさない
" 昔の書き方
" set visualbell t_vb=
" set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
" 今の書き方
set belloff=all

" <= 見た目 }}}

" => カスタムコマンド {{{1

" ウィンドウは閉じずにバッファを閉じる
command! Bd :bp | :sp | :bn | :bd

" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<cr> :e! <cr>

" ターミナルからノーマルに移動するコマンド googlechrome用 <C-x>
tnoremap <c-x> <c-w>N

" ターミナルからノーマルに移動するコマンド <ESC>
tnoremap <ESC> <c-w>N

" 挿入モードからノーマルモードへホームポジションを離れずに戻る jk
inoremap jk <ESC>

" バッファ削除
nnoremap <C-c> :BD<cr>

" xやsではヤンクしない
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_s

" => InsertモードでEmacsキーバインド {{{2

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <C-r>=<SID>kill()<CR>

" 一応viモードでもカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" <= InsertモードでEmacsキーバインド }}}

" => [括弧補完] {{{2

inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap () ()
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>

inoremap '' ''
inoremap ' ''<ESC>i
inoremap "" ""
inoremap " ""<ESC>i
inoremap < <><ESC>i

" <= [括弧補完] }}}

" => [git-gutter操作] {{{2

" g]で前の変更箇所へ移動する
nnoremap g[ :GitGutterPrevHunk<CR>

" g[で次の変更箇所へ移動する
nnoremap g] :GitGutterNextHunk<CR>

" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>

" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>

" <= [git-gutter操作] }}}

" => [fzf操作] {{{2

" fmなどf[文字]コマンドにしたかったがf[文字]の行検索は使いたいのでtを割り当てた
" tfでファイル一覧を開く
nnoremap tf :Files<cr>

" tgでGitリポジトリのファイル一覧を開く
nnoremap tg :GFiles<cr>

" tbでバッファ一覧を開く
nnoremap tb :Buffers<cr>

" tmでマーク検索を開く
nnoremap tm :Marks<cr>

" thでファイル閲覧履歴検索を開く
nnoremap th :History<cr>

" fcでコミット履歴検索を開く
nnoremap tc :Commits<cr>

" <= [fzf操作] }}}

" => [Airline tab操作] {{{2

" Ctrl+n で次のバッファに移動する
nnoremap <c-n> :bnext<cr>

" Ctrl+p で前のバッファに移動する
nnoremap <c-p> :bprev<cr>

" <= [Airline tab操作] }}}

" <= カスタムコマンド }}}

" => Leader ショートカット {{{1

" Leaderキーをバックスラッシュからスペースに変更する
let mapleader = "\<space>"

" <Leader> + n で NERDTreeをトグルする
nnoremap <leader>n :NERDTreeToggle<cr>

" <Leader> + e で Fernをトグルする
nnoremap <leader>e :Fern . -reveal=% -drawer -toggle -width=40<cr>

" <Leader> + G で GitGutterをトグルする
nnoremap <leader>G :GitGutterToggle<cr>

" <Leader> + w で Ctrl+w 入力にする for googlechrome
nnoremap <leader>w <C-w>

" <Leader> + b でバッファ検索を開く (fzf)
nnoremap <leader>b :Buffers<cr>

" <Leader> + h で履歴検索を開く (fzf)
nnoremap <leader>h :History<cr>

" <Leader> + l で開いているファイルの文字列検索を開く (fzf)
nnoremap <leader>l :BLines<cr>

" <Leader> + f でファイル検索を開く (fzf)
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <leader>f :call FzfOmniFiles()<CR>

" <leader> + g で文字列検索を開く
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}),
\ <bang>0)
nnoremap <leader>g :Rg<CR>

" <leader> + w でカーソル位置の単語をファイル検索する
nnoremap <leader>w vawy:Rg <c-r>"<cr>

" <leader> + w で範囲選択した単語をファイル検索する
xnoremap <leader>w y:Rg <c-r>"<cr>

" <leader> + p でprettier
nnoremap <leader>p :call CocAction('format')<cr>

" <= Leader ショートカット }}}

" => 移動・検索 {{{1

" コントロールキーとhjklで分割されたウィンドウ間をすばやく移動する
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

" ESC連打で検索ハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<cr>

" 検索結果をハイライトする
set hlsearch

" 大文字小文字を区別しないで検索
set ignorecase

" 検索パターンに大文字が含まれていたらignorecaseを無効化する
set smartcase

" 検索をタイプするたびに動的に最初のマッチに移動する
set incsearch

" 最後尾まで検索を終えたら次の検索で先頭に移る
set wrapscan

" <= 移動・検索 }}}

" => ファイルタイプ別設定 {{{1

" <= ファイルタイプ別設定 }}}

" => その他・hack {{{1

" ターミナルウィンドをアクティブバッファリストから隠す (for ]b and [b)
autocmd TerminalOpen * if bufwinnr('') > 0 | setlocal nobuflisted | endif

" コードを折りたたむ zo:open, zc:close zR:all open, zM: all close
set foldmethod=indent

" 新しいファイルを開くときは折り畳みが開いているようにする
autocmd BufRead * normal zR

" 親ディレクトリにあるtagsファイルを再帰的に探す
" ctags -R . しておくこと
set tags=./tags;,tags

" 挿入モードからノーマルモードへのESC切り替え遅延をなくす
set ttimeoutlen=50

" ターミナルでコピペしてもインデントしないようにする (:set pasteを不要にする)
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" <= その他 }}}

" => Plugin毎の設定 {{{1

" => [NERDTree] 設定 {{{2

" 起動時にブックマークを表示
let NERDTreeShowBookmarks = 1

" アイコン表示
let g:webdevicons_enable_nerdtree = 1

" NERDTreeのウィンドウしか開かれていないときは自動的にとじる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
  \ b:NERDTree.isTabTree()) | q | endif

" <= [NERDTree] 設定 }}}

" => [winresizer] 設定 {{{2

" ウィンドウリサイズ量をデフォルトの3から1に変更
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" <= [winresizer] 設定 }}}

" => [vim-cheatsheet] 設定 {{{2

let g:cheatsheet#cheat_file = '~/.cheatsheet.md'

" <= [vim-cheatsheet] 設定 }}}

" => [previm] 設定 {{{2

" WSLで動かす
let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
let g:previm_wsl_mode = 1

" <= [previm] 設定 }}}

" => [indentLine] 設定 {{{2

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#708090'

" <= [indentLine] 設定 }}}

" => [vim-table-mode] 設定 {{{2

let g:table_mode_corner = '|'

" <= [vim-table-mode] 設定 }}}

" => [vim-closetag] 設定 {{{2

let g:closetag_filenames = '*.html,*.vue'

" <= [vim-closetag] 設定 }}}

" => [vim-airline] 設定 {{{2

" タブラインを有効化
let g:airline#extensions#tabline#enabled = 1

" ファイルパス表示を無効化
let g:airline#extensions#tabline#fnamemod = ':t'

" <= [vim-airline] 設定 }}}

" => [fern] 設定 {{{2

let g:fern#renderer = 'nerdfont'

" <= [fern] 設定 }}}

" => [git-gutter] 設定 {{{2

" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

" 反映時間を短くする (デフォルトは4000ms)
set updatetime=250

" <= [git-gutter] 設定 }}}

" => [quickrun] 設定 {{{2

let g:quickrun_config={'_': {'split': ''}}

" => [quickrun] 設定 }}}

" <= Plugin毎の設定 }}}

