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
Plug 'itchyny/lightline.vim'
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
Plug 'heavenshell/vim-pydocstring'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'bpearson/vim-phpcs'
Plug 'Shougo/echodoc.vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"Plug 'gkapfham/vim-vitamin-onec'
Plug 'junegunn/vim-peekaboo'

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

set tags=./.tags;
let g:easytags_dynamic_files = 2

" Keybinds
nmap <silent> <C-_> <Plug>(pydocstring)
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
map <F4> <Esc>:registers<CR>
map <F9> :History<CR>
nmap <F10> :TagbarToggle<CR>
nmap <F11> :Tags<CR>
nnoremap <C-h> :BTags<CR>

let g:ctrlp_cmd = 'Files'
nnoremap <C-l> :CtrlPBuffer<CR>
map <F1> <del>
map! <F1> <del>

command Wordpress let g:ale_php_phpcs_standard = 'Wordpress'
command Json :execute '%!python -m json.tool' | w
command Todo :edit ~/dev/todo.org | set ft=org

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

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

let g:lightline = {
  \ 'colorscheme': 'powerline',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [[ 'cocstatus', 'currentfunction' ],
  \             [ 'lineinfo', 'percent' ],
  \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'StatusDiagnostic',
  \   'currentfunction': 'CocCurrentFunction'
  \ },
  \ }

set updatetime=300
set cpo+=d

function MyCustomHighlights()
    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=214 guifg=#ffffff cterm=none gui=none
    hi semshiParameter       ctermfg=75  guifg=#5fafff
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    hi semshiAttribute       ctermfg=49  guifg=#00ffaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction
autocmd FileType python call MyCustomHighlights()
