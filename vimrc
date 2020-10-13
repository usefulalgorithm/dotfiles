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
" If you don't need Airline features, use Lightline and buftabline instead
"Plug 'itchyny/lightline.vim'
"Plug 'ap/vim-buftabline'
Plug 'powerline/fonts'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'konfekt/fastfold'
call plug#end()

set t_Co=256
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
set confirm
set visualbell
set backspace=indent,eol,start
"set cmdheight=2
set number relativenumber
set shiftwidth=2
set softtabstop=2
set expandtab
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <C-N> :set invnumber<CR> 
set pastetoggle=<F10>

" ======= UNDO =======
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
if has("persistent_undo")
  if !isdirectory(&undodir)
    silent call system('mkdir -p ' . &undodir)
  endif
endif
" ===================

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" Airline already tells us which mode we're in!
set noshowmode

" For ctags
set tags=./tags,./TAGS,tags;~,TAGS;~

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

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set foldmethod=syntax
set foldlevelstart=20
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nmap <F2> :NERDTreeToggle<CR>
nmap <tab> :bnext<CR>
nmap <S-tab> :bprevious<CR>
nmap <leader>l :ls<CR>
nmap <leader>q :bp <BAR> bd #<CR>
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

nmap <F8> :TagbarToggle<CR>

" vim airline conigurations
" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts = 1 
" enable tabline
let g:airline#extensions#tabline#enabled = 1 
" set left separator
let g:airline#extensions#tabline#left_sep = ' ' 
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|' 
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1 
" change vim airline theme
let g:airline_theme='molokai'
" display git branch
let g:airline#extensions#branch#enabled = 1 

let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '✗' 
let g:ale_sign_warning = '⚡'

" Needs stylish haskell, so remember to do `stack install stylish-haskell`
autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
autocmd FileType haskell let b:autoformat_autoindent=0

" ======= INCSEARCH.vim =======
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" === INCSEARCH-FUZZY.vim =====
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" ======= FASTFOLD.vim ========
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1 
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" =========== MISC ============
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" =============================
