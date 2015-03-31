set t_Co=256
set fileencoding=utf-8
set encoding=utf-8
set enc=utf-8
set termencoding=utf-8
set expandtab
"set smarttab
set shiftwidth=4
set softtabstop=4
syntax on
set background=dark
filetype indent plugin on
colorscheme jellybeans
set modeline
set mouse=a
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    colorscheme vydark
endif

nnoremap <silent> <C-t> <Esc>:tabnew<CR>
map <F4> <Esc>:registers<CR>

" restore screen after quitting
set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
if has("terminfo")
  let &t_Sf="\ESC[3%p1%dm"
  let &t_Sb="\ESC[4%p1%dm"
else
  let &t_Sf="\ESC[3%dm"
  let &t_Sb="\ESC[4%dm"
endif

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Plugarit tähän
Plugin 'itchyny/lightline.vim'
Plugin 'mattn/emmet-vim'
"Plugin 'jaxbot/brolink.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ervandew/supertab'
Plugin 'lepture/vim-jinja'
Plugin 'xsbeats/vim-blade'
Plugin 'burnettk/vim-angular'
Plugin 'scrooloose/syntastic'
"Plugin 'klen/python-mode'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'


call vundle#end()
filetype plugin indent on
" vundle end

" Latex stuff
nnoremap <F6> :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <F7> :!mupdf %:r.pdf &<CR><CR>

map <F5> :PluginInstall<CR>
map <F2> :NERDTreeTabsToggle<CR>
map <F9> :CtrlPMRU<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
set laststatus=2
set pastetoggle=<F3>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd FileType yaml set shiftwidth=2|set softtabstop=2
set fillchars+=vert:┃
set dir=~/.vimswap/_swap//
set backup
set backupdir=~/.vimswap/_backup/,~/tmp,.
let g:syntastic_python_flake8_post_args='--ignore=E128'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
