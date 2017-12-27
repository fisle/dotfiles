set t_Co=256
set fileencoding=utf-8
set encoding=utf-8
set enc=utf-8
set termencoding=utf-8

set expandtab
set shiftwidth=4
set softtabstop=4
"colorscheme monokai
colorscheme jellybeans

syntax on
set mouse=a
set modeline
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
filetype indent plugin on

set scrolloff=1
set sidescrolloff=5

let no_autopep8_maps = 1

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Plugarit
Plugin 'itchyny/lightline.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/deoplete.nvim'
Plugin 'lepture/vim-jinja'
Plugin 'w0rp/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'bpearson/vim-phpcs'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'digitaltoad/vim-jade'
Plugin 'junegunn/goyo.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/Tabmerge'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'tell-k/vim-autopep8'
Plugin 'majutsushi/tagbar'
Plugin 'evidens/vim-twig'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'saltstack/salt-vim'
Plugin 'jwalton512/vim-blade'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mxw/vim-jsx'
Plugin 'maximbaz/lightline-ale'


call vundle#end()
filetype plugin indent on
" vundle end

" Custom functions
cmap w!! w !sudo tee > /dev/null %

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
        set number
    endif
endfunc

let @f = 'f,a€kD'

set statusline+=%{ALEGetStatusLine()}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'python': ['flake8', 'python'],
\   'php': ['php', 'phpcs', 'phpmd'],
\   'go': ['go', 'gofmt', 'golint', 'gotype', 'govet'],
\   'bash': ['shellcheck'],
\}
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_statusline_format = ['¿ %d', '¿ %d', '¿ ok']

let g:lightline = { 'colorscheme': 'powerline' }
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
let g:lightline.active = {
    \ 'right': [['linter_errors', 'linter_warnings', 'linter_ok'], ['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype']],
    \ 'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']]
    \ }
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"let g:ale_open_list = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Keybinds
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
map <F4> <Esc>:registers<CR>
nnoremap <F6> :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <F7> :!mupdf %:r.pdf &<CR><CR>
nnoremap <F8> :!md2pdf % & <CR>
map <F9> :CtrlPMRU<CR>
nmap <F10> :TagbarToggle<CR>
nmap <F11> :CtrlPTag<CR>
" Use FZF instead of CtrlP
let g:ctrlp_cmd = 'Files'
nnoremap <C-l> :CtrlPBuffer<CR>
map <F1> <del>
map! <F1> <del>
"map <C-m> :let g:ale_php_phpcs_standard = 'Wordpress'<CR>
command Wordpress let g:ale_php_phpcs_standard = 'Wordpress'

nnoremap <silent> <C-t> <Esc>:tabnew<CR>
nnoremap <C-n> :call NumberToggle()<CR>

set laststatus=2

autocmd FileType yaml set shiftwidth=2|set softtabstop=2
autocmd FileType * if &filetype == 'python' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'javascript' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'php' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'go' | set colorcolumn=80,100 | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set fillchars+=vert:â”ƒ

" set dir=~/.vimswap/_swap//
" set backup
" set backupdir=~/.vimswap/_backup/,~/tmp,.
" set backupcopy=yes
set nobackup
set noswapfile

set statusline+=%#warningmsg#

set statusline+=%*
set cursorline

let g:autopep8_ignore=''
let g:autopep8_max_line_length=99
let g:autopep8_aggressive=1

let NERDTreeIgnore = ['\.pyc$']
" hi Directory guifg=#FFFFFF ctermfg=4

" set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

let g:goyo_width=100
let g:goyo_height=90
function! s:goyo_enter()
    GitGutterEnable
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
let g:deoplete#enable_at_startup = 1
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:jsx_ext_required = 0 " allow jsx in js files
