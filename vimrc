if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ap/vim-buftabline'
call plug#end()

set t_Co=16
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

set hidden
set nocompatible
filetype indent plugin on
syntax on
set wildmenu
set showcmd
set hlsearch
set autoindent
set nostartofline
set ignorecase
set smartcase
set ruler
set laststatus=2
set confirm
set visualbell
set backspace=indent,eol,start
"set cmdheight=2
set number
set shiftwidth=2
set softtabstop=2
set expandtab
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <C-N> :set invnumber<CR> 
set pastetoggle=<F10>

" Cscope magic
if has('cscope')
  set cscopetag

  "  if has('quickfix')
  "    set cscopequickfix=s-,c-,d-,i-,t-,e-
  "  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>

set foldmethod=syntax
set foldlevelstart=20
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nmap <F2> :NERDTreeToggle<CR>
nmap <tab> :bnext<CR>
nmap <S-tab> :bprevious<CR>
nmap <leader>bl :ls<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
