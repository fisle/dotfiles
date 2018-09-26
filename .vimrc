set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

set expandtab
set shiftwidth=4
set softtabstop=4
set termguicolors

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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/Tabmerge'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tell-k/vim-autopep8'
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-easytags'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'fisle/vim-no-fixme'
Plugin 'xolox/vim-misc'

" Linters/etc
Plugin 'w0rp/ale'
Plugin 'stsewd/isort.nvim'
Plugin 'maximbaz/lightline-ale'
Plugin 'bpearson/vim-phpcs'
Plugin 'autozimu/LanguageClient-neovim'

" Colors
Plugin 'joshdick/onedark.vim'
Plugin 'morhetz/gruvbox'

" Sugar
Plugin 'gorodinskiy/vim-coloresque'

" Best language pack (syntax etc)
Plugin 'sheerun/vim-polyglot'
Plugin 'alampros/vim-styled-jsx'

" Syntax - DEPRECATED Use polyglot
" Plugin 'lepture/vim-jinja'
" Plugin 'digitaltoad/vim-jade'
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'pangloss/vim-javascript'
" Plugin 'posva/vim-vue'
" Plugin 'evidens/vim-twig'
" Plugin 'ekalinin/Dockerfile.vim'
" Plugin 'saltstack/salt-vim'
" Plugin 'jwalton512/vim-blade'
" Plugin 'maxmellon/vim-jsx-pretty'
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'vim-python/python-syntax'
" Plugin 'martinda/Jenkinsfile-vim-syntax'

call vundle#end()
filetype plugin indent on
" vundle end

let g:python_highlight_all = 1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR><Paste>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
let g:LanguageClient_diagnosticsEnable = 0

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
\ }

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

let @f = 'f,akD'

set statusline+=%{ALEGetStatusLine()}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
"\   'python': ['flake8', 'pylint', 'python'],
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'php': ['php', 'phpcs', 'phpmd'],
\   'go': ['go', 'gofmt', 'golint', 'gotype', 'govet'],
\   'bash': ['shellcheck'],
\}

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_statusline_format = ['¿ %d', '¿ %d', '¿ ok']

let g:lightline = { 'colorscheme': 'powerline' }
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'nofixme': 'nofixme#amount',
      \ }
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'nofixme': 'warning',
      \ }
let g:lightline.active = {
    \ 'right': [['linter_errors', 'linter_warnings', 'linter_ok', 'nofixme'], ['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype']],
    \ 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']]
    \ }

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
nnoremap <C-h> :CtrlPTag<CR>
map <F1> <del>
map! <F1> <del>
"map <C-m> :let g:ale_php_phpcs_standard = 'Wordpress'<CR>
command Wordpress let g:ale_php_phpcs_standard = 'Wordpress'
command Json :execute '%!python -m json.tool' | w
command Todo :edit ~/dev/todo.md

nnoremap <silent> <C-t> <Esc>:tabnew<CR>
nnoremap <C-n> :call NumberToggle()<CR>

set laststatus=2

autocmd FileType yaml set shiftwidth=2|set softtabstop=2
autocmd FileType * if &filetype == 'python' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'javascript' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'php' | set colorcolumn=80,100 | endif
autocmd FileType * if &filetype == 'go' | set colorcolumn=80,100 | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set fillchars+=vert:┃
"set fillchars+=vert:â

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

let g:easytags_async = 1
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
" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" let g:deoplete#sources = {}
" let g:deoplete#sources.cpp = ['LanguageClient']
" let g:deoplete#sources.python = ['LanguageClient']
" let g:deoplete#sources.python3 = ['LanguageClient']
" let g:deoplete#sources.rust = ['LanguageClient']
" let g:deoplete#sources.c = ['LanguageClient']
" let g:deoplete#sources.vim = ['vim']

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:jsx_ext_required = 0 " allow jsx in js files
let g:vim_jsx_pretty_colorful_config = 1

set background=dark
"colorscheme monokai
"colorscheme jellybeans
"colorscheme gruvbox
colorscheme onedark
