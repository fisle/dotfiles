"set t_Co=256
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

set hidden

set nobackup
set nowritebackup
set noswapfile

set shortmess+=c

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
Plug 'f-person/git-blame.nvim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'vim-scripts/Tabmerge'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
Plug 'heavenshell/vim-pydocstring'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'bpearson/vim-phpcs'
Plug 'Shougo/echodoc.vim'
"Plug 'joshdick/onedark.vim'
"Plug 'rafi/awesome-vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"Plug 'junegunn/vim-peekaboo'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'AckslD/nvim-revJ.lua'
"Plug 'yamatsum/nvim-cursorline'
Plug 'junegunn/goyo.vim'
Plug 'sainnhe/edge'
"Plug 'mhartington/oceanic-next'
"Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'lukas-reineke/indent-blankline.nvim'

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
let g:gutentags_ctags_tagfile = '.tags'

" Keybinds
"map <F1> <del>
"map! <F1> <del>
map <F1> <Esc>:registers<CR>
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
nnoremap <F5> :UndotreeToggle<CR>
map <F9> :History<CR>
nmap <F10> :TagbarToggle<CR>
nmap <F11> :Tags<CR>

nmap <silent> <C-_> <Plug>(pydocstring)
nnoremap <C-h> :BTags<CR>
" Escape from terminal with jj
tnoremap jj <C-\><C-n>

" let g:ctrlp_cmd = 'Files'
" nnoremap <C-l> :CtrlPBuffer<CR>
nnoremap <C-l> :Buffers<CR>
nnoremap <C-p> :Files<CR>

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
"set nocursorline
set cursorline
"set cursorcolumn

let NERDTreeIgnore = ['\.pyc$']

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

let $FZF_DEFAULT_COMMAND = 'ag -U -g ""'

let g:jsx_ext_required = 0 " allow jsx in js files
let g:vim_jsx_pretty_colorful_config = 1

set background=dark
"colorscheme onedark

let g:vim_action_ag_escape_chars = '#%.^$*+?()[{\\|'

" Disable deoplete opening scratch
set completeopt-=preview

let mapleader="\<Space>"
let maplocalleader="-"

nnoremap <silent> <localleader>h ?TODO\\|FIXME<CR>
nnoremap <silent> <localleader>l /TODO\\|FIXME<CR>

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)
nmap <localleader>k <Plug>(GitGutterPrevHunk)
nmap <localleader>j <Plug>(GitGutterNextHunk)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gD :call CocAction('jumpDefinition', 'tabe')<CR>
" Trigger completion ctrl+space
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

command -nargs=0 Swagger :CocCommand swagger.render

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

lua << EOF
require("revj").setup{
    brackets = {first = '([{<', last = ')]}>'}, -- brackets to consider surrounding arguments
    new_line_before_last_bracket = true, -- add new line between last argument and last bracket (only if no last seperator)
    add_seperator_for_last_parameter = true, -- if a seperator should be added if not present after last parameter
    enable_default_keymaps = false, -- enables default keymaps without having to set them below
    keymaps = {
        operator = '<Leader>J', -- for operator (+motion)
        line = '<Leader>j', -- for formatting current line
        visual = '<Leader>j', -- for formatting visual selection
    },
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "c", "rust" },  -- list of language that will be disabled
    },
}
EOF

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
colo edge

let g:goyo_width=100
let g:goyo_height=90

function! s:goyo_enter()
    GitGutterEnable
    "silent! call lightline#enable()
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:gitblame_date_format = '%r'
highlight link TSError Normal
let g:indent_blankline_use_treesitter = v:true

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
