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
" */

" /* Text, Tab & Indent

set tabstop=4               "4 space tab indents by default
set softtabstop=4           "Make backspace delete 4 spaces at once
set shiftwidth=4            "Used with < and > for block indenting
set expandtab               "Insert spaces instead of tabs

set autoindent              "Indent new lines the same as previous ones
set textwidth=80            "Wrap (if set for filetype) at column 80

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
set nohlsearch              "Don't highlight search results
set incsearch               "Highlight matches while searching
set novisualbell            "Don't do the blinking thing
set clipboard=unnamed       "Use system clipboard

" */  

" /* Mappings
 
" Moving tab using CTRL+ the arrows
map <C-right> gt<CR>
map <C-left> gT<CR>

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

" */
