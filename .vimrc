set t_Co=256
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if has('gui_running')
    set guioptions-=e
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guifont=Ubuntu\ Mono\ 9
endif

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
" let g:ale_completion_enabled = 1

call plug#begin('~/.vim/bundle')

" Plugarit
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'vim-scripts/Tabmerge'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'Wraul/vim-easytags', { 'branch': 'fix-universal-detection' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'fisle/vim-no-fixme'
Plug 'xolox/vim-misc'
Plug 'heavenshell/vim-pydocstring'
Plug 'jceb/vim-orgmode'

Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'bpearson/vim-phpcs'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/echodoc.vim'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"Plug 'mgee/lightline-bufferline'

" Colors
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" Sugar
Plug 'gorodinskiy/vim-coloresque'

" Best language pack (syntax etc)
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'

" Syntax - DEPRECATED Use polyglot
Plug 'lepture/vim-jinja'
" Plug 'digitaltoad/vim-jade'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'
" Plug 'posva/vim-vue'
" Plug 'evidens/vim-twig'
" Plug 'ekalinin/Dockerfile.vim'
" Plug 'saltstack/salt-vim'
" Plug 'jwalton512/vim-blade'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'vim-python/python-syntax'
" Plug 'martinda/Jenkinsfile-vim-syntax'

call plug#end()

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

let g:python_highlight_all = 1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
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
let g:ale_echo_msg_format = '%linter%: %s %(code)%'
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'php': ['php', 'phpcs'],
\   'go': ['go', 'gofmt', 'golint', 'gotype', 'govet'],
\   'bash': ['shellcheck'],
\   'python': ['flake8', 'pylint', 'mypy'],
\}

let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_options = '--ignore=F401'
" Disable auto-detection of virtual envs, falls back on ${VIRTUAL_ENV}
" let g:ale_virtualenv_dir_names = []

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['python'] = ['isort', 'autopep8']
let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_fix_on_save = 1
let g:ale_python_pylint_change_directory = 0

let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_statusline_format = ['¿ %d', '¿ %d', '¿ ok']

set showtabline=2
let g:lightline = {}
let g:lightline.colorscheme = 'powerline'
let g:lightline.component_expand = {
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \ }
let g:lightline.component_type = {
    \ 'linter_checking': 'left',
    \ 'linter_warnings': 'warning',
    \ 'linter_errors': 'error',
    \ 'linter_ok': 'left',
    \ }
let g:lightline.active = {
    \ 'right': [['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'], ['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype']],
    \ 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']]
    \ }

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Keybinds
nmap <silent> <C-_> <Plug>(pydocstring)
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
map <F4> <Esc>:registers<CR>
nnoremap <F6> :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <F7> :!mupdf %:r.pdf &<CR><CR>
nnoremap <F8> :!md2pdf % & <CR>
map <F9> :CtrlPMRU<CR>
nmap <F10> :TagbarToggle<CR>
nmap <F11> :CtrlPTag<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Use FZF instead of CtrlP
let g:ctrlp_cmd = 'Files'
nnoremap <C-l> :CtrlPBuffer<CR>
nnoremap <C-h> :CtrlPTag<CR>
map <F1> <del>
map! <F1> <del>
"map <C-m> :let g:ale_php_phpcs_standard = 'Wordpress'<CR>
command Wordpress let g:ale_php_phpcs_standard = 'Wordpress'
command Json :execute '%!python -m json.tool' | w
command Todo :edit ~/dev/todo.org

nnoremap <silent> <C-t> <Esc>:tabnew<CR>
nnoremap <C-b> :call NumberToggle()<CR>

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

let g:vim_action_ag_escape_chars = '#%.^$*+?()[{\\|'

" Disable deoplete opening scratch
set completeopt-=preview
