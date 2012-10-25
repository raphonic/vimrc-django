set nocompatible            "Behave less like vi

" Vundle /*
if !isdirectory(expand("~/.vim/bundle/vundle/"))
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

    " Reload vimrc
    source ~/.vimrc

    " Directory required for persistent undo history
    if !isdirectory(expand("~/.vim/undodir/"))
        silent !mkdir ~/.vim/undodir/
    endif

    " Install/Update plugins
    BundleInstall!
    source ~/.vimrc
endif

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin manager
Bundle 'gmarik/vundle'

" File Browser
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" Color scheme
Bundle 'chriskempson/vim-tomorrow-theme'

" Commenting
Bundle 'scrooloose/nerdcommenter'

" Syntax checking
Bundle 'scrooloose/syntastic'

" Status line
Bundle 'zeekay/vim-powerline-hax'
Bundle 'Lokaltog/vim-powerline'

" Smart python indentation
Bundle 'vim-scripts/indentpython.vim'

" Automatic ctags generation
Bundle 'vim-scripts/DfrankUtil'
Bundle 'vim-scripts/vimprj'
Bundle 'vim-scripts/indexer.tar.gz'

filetype plugin on
filetype indent on

" */

" /* Plugin settings

let NERDTreeIgnore=['\~$','.pyc$']
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
let NERDTreeMinimalUI=1
let NERDTreeWinSize=31
let g:nerdtree_tabs_open_on_console_startup=0

let g:flake8_ignore="E501"
    
let g:indexer_disableCtagsWarning=1

" */

" /*  General

autocmd BufEnter ~/.vimrc set foldmarker=/*,*/   "Foldable section boundaries
autocmd BufEnter ~/.vimrc set foldmethod=marker  "Fold this vimrc into sections
autocmd BufLeave ~/.vimrc set foldmethod=manual  "Switch back to manual folding everywhere else
set foldmethod=manual

set textwidth=0             "Never wrap
set lazyredraw              "Don't redraw while running macros
set shortmess=atI           "Shorten messages to avoid 'press ENTER' prompts
set noerrorbells            "Don't make noises
syntax on                   "Syntax highlighting

set title                   "Show title in console title

set nobackup                "Don't backup
set noswapfile              "Don't make swap files

let mapleader = ","
let g:mapleader = ","

set laststatus=2            " Always display a status line
" */

" /* Text, Tab & Indent

set tabstop=4               "4 space tab indents by default
set softtabstop=4           "Make backspace delete 4 spaces at once
set shiftwidth=4            "Used with < and > for block indenting
set expandtab               "Insert spaces instead of tabs

set autoindent              "Indent new lines the same as previous ones
set nowrap                  "Don't wrap lines

set colorcolumn=80          "Reminder not to make lines too long

" */

" /*  Backup and history

set history=1000            "Set larger undo/redo memory
set undodir=~/.vim/undodir  "Set history storage directory
set undofile                "Set persistent history

" */

" /* Interface

set scrolloff=5             "Show >5 lines above/below cursor when possible
set number                  "Show line numbers
set mouse=a                 "Enable mouse in console
set whichwrap+=<,>,[,],h,l  "Allow cursor keys to cross line boundaries
set showmatch               "Show matching brackets
set incsearch               "Highlight matches while searching
set hlsearch                "Highlight search results
set smartcase
set novisualbell            "Don't do the blinking thing
set clipboard=unnamedplus   "Use system clipboard
set list                    "Show whitespace

"Set how whitespace is displayed
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
set listchars=tab:᚛-,eol:ᚌ

" */

" /* Mappings
 

" When I'm trying to learn to use vim properly
"map <left> <nop>
"map <right> <nop>
"map <up> <nop>
"map <down> <nop>

"The rest of the time
map <left> h
map <right> l
map <up> k
map <down> j

" Move between windows with shift + direction
map <S-l> <C-w>l
map <S-h> <C-w>h
map <S-k> <C-w>k
map <S-j> <C-w>j
map <S-right> <C-w>l
map <S-left> <C-w>h
map <S-up> <C-w>k
map <S-down> <C-w>j


map <C-right> gt
map <C-left> gT
map <silent> <C-S-right> :call MoveCurTab(1)<CR>
map <silent> <C-S-left> :call MoveCurTab(-1)<CR>
map <silent> <leader>/ :nohlsearch<CR>

map \ :NERDTreeTabsToggle<CR>

"Toggle folds with <Space> (Normal Mode)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"Create folds with <Space> (Visual Mode)
vnoremap <Space> zf    

"Visual commenting
set notildeop
vmap # <leader>c<space>

"Open tag in new window
":TODO: Do this only when a match is found
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" */

" /* Colors and fonts 

set t_Co=256                "Set console to display 256 colors                

"Hide warnings about colorscheme not being found on first run
silent! colorscheme Tomorrow-Night

"Change parenethesis matching style
hi MatchParen cterm=none ctermbg=none ctermfg=red  "Less awful match styling

" */

" /* Filetype Specific

au BufNewFile,BufRead *.html setlocal filetype=htmldjango

"Highlight whitespace differently for html,xml
autocmd FileType html setlocal listchars-=tab:>.

"Use real tabs in html,js and css files (Work convention)

au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead settings.py  setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django

autocmd FileType javascript,html,css set noet
autocmd FileType python set et

let g:syntastic_python_checker_args='--ignore=E501'
" */

" /* Autocompletion
" TODO: Automate this for more awesomeness

" Set these two environment variables to allow django completion
let $PYTHONPATH='/home/ben/Workspace/awardhoard'
let $DJANGO_SETTINGS_MODULE='awardhoard-web.settings'

" Use super tab context sensitive mode
let g:SuperTabDefaultCompletionType = "context"
" Close preview window when completion popup exits
let g:SuperTabClosePreviewOnPopupClose = 1
" */

" /* Functions 

" Reload vimrc when saved
autocmd! BufWritePost ~/.vimrc source ~/.vimrc

if !exists("*MoveCurTab")
    function MoveCurTab(value)
      let move = a:value - 1
      let move_to = tabpagenr() + move
      if move_to < 0
        let move_to = 0
      endif
      exe 'tabmove '.move_to
    endfunction
endif
