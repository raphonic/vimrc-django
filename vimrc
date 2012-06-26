set nocompatible            "Behave less like vi

" Install plugin manager
if !isdirectory(expand("~/.vim/bundle/vundle/"))
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif

" /* Vundle Plugins
autocmd! BufRead ~/.vimrc call Setup()

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin manager
Bundle 'gmarik/vundle'

" File Browser
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" Color scheme
Bundle 'cschlueter/vim-mustang'

" Code Completion
Bundle 'ervandew/supertab'

" Python utilities
Bundle 'nvie/vim-flake8'
Bundle 'vim-scripts/indentpython.vim'

filetype plugin indent on
" */ 

" /*  General

setlocal foldmarker=/*,*/   "/* and */ mark boundary of a foldable section
setlocal foldmethod=marker  "Fold this vimrc into sections
set lazyredraw              "Don't redraw while running macros
set shortmess=atI           "Shorten messages to avoid 'press ENTER' prompts
set noerrorbells            "Don't make noises
syntax on                   "Syntax highlighting

set title                   "Show title in console title

set nobackup                "Don't backup
set noswapfile              "Don't make swap files

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
set novisualbell            "Don't do the blinking thing
set clipboard=unnamed       "Use system clipboard
set list                    "Show whitespace

"Set how whitespace is displayed
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
set listchars=tab:ᗒ.,eol:ᨀ

" /* NERDTree

let NERDTreeIgnore=['\~$','.pyc$']
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
let NERDTreeWinPos='right'
let NERDTreeMinimalUI=1
let NERDTreeWinSize=31
let g:nerdtree_tabs_open_on_console_startup=1

" */

" */  

" /* Mappings
 

" When I'm trying to learn to use vim properly
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>

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


map <C-right> gT
map <C-left> gt
map <C-S-right> :call MoveCurTab(1)<CR>
map <C-S-left> :call MoveCurTab(-1)<CR>
map <silent> ,/ :nohlsearch<CR>

"Toggle folds with <Space> (Normal Mode)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"Create folds with <Space> (Visual Mode)
vnoremap <Space> zf    

" */

" /* Colors and fonts

set t_Co=256                "Set console to display 256 colors                

"Hide warnings about colorscheme not being found on first run
silent! colorscheme mustang

" */

" /* Filetype Specific

    "Highlight whitespace differently for html,xml
    autocmd filetype html,xml set listchars-=tab:>.

    "Use real tabs in html,js and css files (Work convention)
    autocmd filetype html,css,js set noexpandtab

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

" Prevent Setup() being called twice
if !exists("*Setup")
    function! Setup()
        " Directory required for persisten undo history
        if !isdirectory(expand("~/.vim/undodir/"))
            silent !mkdir ~/.vim/undodir/
        endif

        " Install/Update plugins
        BundleInstall!

        " Close installer buffer when complete
        bdelete "[Vundle] installer"

        " Reload vimrc
        source ~/.vimrc
    endfunction
endif

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

" */
