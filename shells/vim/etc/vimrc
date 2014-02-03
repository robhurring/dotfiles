set nocompatible               " be iMproved
filetype off                   " required!

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on     " required!

" Display options
syntax on
set cursorline
set showcmd
set number
set list                       " Display unprintable characters
set listchars=tab:▸\ ,extends:»,precedes:«
if $TERM =~ '256color'
  set t_Co=256
elseif $TERM =~ '^xterm$'
  set t_Co=256
endif

colorscheme jellybeans

" Misc
filetype plugin indent on       " Do filetype detection and load custom file plugins and indent files
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set updatecount=100             " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set scrolloff=3                 " Start scrolling 3 lines before the horizontal window border
set noerrorbells                " Disable error bells

" use relative line numbers
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber
autocmd BufEnter * set relativenumber

" up/down on displayed lines, not real lines. More useful than painful.
noremap k gk
noremap j gj

" Indentation and tabbing
set autoindent smartindent
set smarttab
set tabstop=2
set expandtab
set shiftwidth=2

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :100 : up to 100 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo='100,/100,h,\"500,:100,n~/.vim/viminfo

" Keybindings to native vim features
let mapleader=","
let localmapleader=","
map <Leader>/ :nohlsearch<cr>
map <M-[> :tprev<CR>
map <M-]> :tnext<CR>
vnoremap . :normal .<CR>
vnoremap @ :normal! @
" map <T-j> :bn<cr>
" map <T-k> :bp<cr>

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif |

" Always edit file, even when swap file is found
set shortmess+=A

" Toggle paste mode while in insert mode with F12
set pastetoggle=<F12>

au BufNewFile,BufRead *.less set filetype=less

imap <S-CR> <CR><CR>end<Esc>-cc

"""""""""""""""""""""
" Plugins
"""""""""""""""""""""

nnoremap <Leader>g :NERDTreeToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

nnoremap <C-y> :YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim/tmp'
let g:yankring_manual_clipboard_check = 0

map <Leader>l :MBEToggle<cr>
let g:miniBufExplorerMoreThanOne = 10000
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplSplitBelow=1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplVSplit = 20

let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['c', 'scss'] }

let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

" let g:Powerline_symbols = 'unicode'
set laststatus=2

let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/log/*,*.zip,*.so,*.swp
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_open_multiple_files = 'h'
"let g:ctrlp_custom_ignore = '\.o\|\.so'
"let g:ctrlp_user_command = 'find %s -type f'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

noremap <leader>a= :Tabularize /=<CR>
noremap <leader>a: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap <leader>a> :Tabularize /=><CR>
noremap <leader>a, :Tabularize /,\zs/l0l1<CR>
noremap <leader>a{ :Tabularize /{<CR>
noremap <leader>a\| :Tabularize /\|<CR>

" splits and such
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
