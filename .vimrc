" 全ての設定を削除する
set all&
" vi互換モードをOFFにする
set nocompatible
syntax on
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
"set autochdir
" ステータスラインを常に表示する
set laststatus=2

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
"set wildmode=list:longest
"set autoindent
"set tabstop=2
"set shiftwidth=2
"colorscheme murphy
"set softtabstop=0
"set ignorecase
"set smartcase
"set incsearch
"set wrapscan
"nmap <Esc><Esc> :nohlsearch<CR><Esc>

