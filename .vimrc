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

"plugarikamaa:
execute pathogen#infect()
"map <F2> :NERDTreeToggle<CR>
map <F2> :NERDTreeTabsToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
set laststatus=2
set pastetoggle=<F3>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd FileType yaml set shiftwidth=2|set softtabstop=2
