syntax on set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cursorline
set number
set backspace=indent,eol,start
set directory-=.

" クリップボードからのペーストをずれないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
      set paste
      return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" 空行を挿入
" nnoremap o :<C-u>call append(expand('.'), '')<Cr>j

" Bundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite file_mruを使用出来るように
NeoBundle 'Shougo/neomru.vim'

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'

" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" インデントの可視化
NeoBundle 'Yggdroot/indentLine'

" Gitを便利に使う
NeoBundle 'tpope/vim-fugitive'

" 行末のスペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'

" gitプラグイン
NeoBundle 'lambdalisue/gina.vim'

" Rails向けのコマンドを提供する
NeoBundle 'tpope/vim-rails'

" 自動補完機能
NeoBundle 'Shougo/neocomplete.vim'

" pluntumlのシンタクスハイライトと:makeコマンド
NeoBundle "aklt/plantuml-syntax"

" 括弧を便利に編集
NeoBundle 'surround.vim'

" vimに非同期処理を実装
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'scrooloose/syntastic'

NeoBundle 'Shougo/unite-outline'

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


"  -----------------------------------------------------
"  neocomplete設定
"  ----------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" end neocomplet
" --------------------------------------------------------------


" 各種設定
" ---------------
" pope/vim-fugitive
" ---------------
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

"----------------------------------------------------------
" Syntasticの設定
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 1
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 0
" ruby以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['ruby'] }
let g:syntastic_ruby_chekers = ['rubocop']

" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}
" plantumlスクリプトの設定
let g:plantuml_executable_script="~/dotfiles/plantuml.sh"

"----------------------------------------------------------
" Unite.vim設定
"----------------------------------------------------------
" Uniteを開いた時にinsertモードで開始
let g:unite_enable_start_insert=1
let g:unite_source_file_mru_limit = 200
let g:unite_source_history_yank_enable =1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Space>j [unite]

nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]j :<C-u>Unite<Space>file_rec/git<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]k :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]cg :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> [unite]u :<C-u>Unite<Space>-no-quit -vertical -winwidth=40 outline<CR>

"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する
