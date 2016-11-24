set t_Co=256
set fileencoding=utf-8
set encoding=utf-8
set enc=utf-8
set termencoding=utf-8


set expandtab
set shiftwidth=4
set softtabstop=4
colorscheme monokai

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
Plugin 'ervandew/supertab'
Plugin 'lepture/vim-jinja'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
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
Plugin 'Shutnik/jshint2.vim'
Plugin 'darthmall/vim-vue'
Plugin 'tell-k/vim-autopep8'
Plugin 'majutsushi/tagbar'
Plugin 'evidens/vim-twig'


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

function! Python2()
    "let g:syntastic_python_checkers = ['flake8-python2']
    let g:syntastic_python_python_exec = '/usr/bin/python2'
    edit %
endfunc

" Latex stuff
nnoremap <F6> :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <F7> :!mupdf %:r.pdf &<CR><CR>
nnoremap <F8> :!md2pdf % & <CR>

" Keybinds
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
map <F4> <Esc>:registers<CR>
map <F5> :PluginInstall<CR>
map <F9> :CtrlPMRU<CR>
nnoremap <F12> :call Python2()<CR>
nnoremap <silent> <C-t> <Esc>:tabnew<CR>
nnoremap <C-n> :call NumberToggle()<CR>
nmap <F10> :TagbarToggle<CR>

set laststatus=2

autocmd FileType yaml set shiftwidth=2|set softtabstop=2
autocmd FileType * if &filetype == 'python' | set colorcolumn=80,100 | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set fillchars+=vert:â”ƒ

set dir=~/.vimswap/_swap//
set backup
set backupdir=~/.vimswap/_backup/,~/tmp,.
set backupcopy=yes
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set cursorline

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_phpcs_args='--standard=PSR2'
let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_javascript_checkers = ['jshint', 'eslint']
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'gotype', 'govet']

let g:autopep8_ignore=''
let g:autopep8_max_line_length=99
let g:autopep8_aggressive=1

let NERDTreeIgnore = ['\.pyc$']
hi Directory guifg=#FFFFFF ctermfg=4

" set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

let g:goyo_width=100
let g:goyo_height=90
function! s:goyo_enter()
    GitGutterEnable
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
