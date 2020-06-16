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

call plug#begin('~/.vim/bundle')

" Plugarit
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'vim-scripts/Tabmerge'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'Wraul/vim-easytags', { 'branch': 'fix-universal-detection' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
Plug 'heavenshell/vim-pydocstring'
Plug 'jceb/vim-orgmode'
Plug 'bpearson/vim-phpcs'
Plug 'Shougo/echodoc.vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" let g:python_highlight_all = 1

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

set showtabline=2

" Keybinds
nmap <silent> <C-_> <Plug>(pydocstring)
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
map <F4> <Esc>:registers<CR>
map <F9> :CtrlPMRU<CR>
nmap <F10> :TagbarToggle<CR>
nmap <F11> :CtrlPTag<CR>
" Use FZF instead of CtrlP
let g:ctrlp_cmd = 'Files'
nnoremap <C-l> :CtrlPBuffer<CR>
nnoremap <C-h> :CtrlPTag<CR>
map <F1> <del>
map! <F1> <del>

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

set nobackup
set noswapfile
set nocursorline

let NERDTreeIgnore = ['\.pyc$']

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

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#tabline#enabled = 1
