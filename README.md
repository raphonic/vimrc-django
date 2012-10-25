vimrc-django
============
Vim config for Django Web Development.
Used on Arch Linux with console vim.

installation
============
Partly automated. Copy/symlink vimrc to `~/.vimrc` and run `vim ~/.vimrc`.

For ctags generation create a `~/.indexer_files` with the following:
```
[PROJECTS_PARENT]
option:ctags_params = "--python-kinds=-i"

~/Workspace
```

requirements
============
vim with python support (in Arch install gvim package to get full featured vim)

External checkers for every filetype you want syntastic to handle, e.g. jslint, flake8

plugins
=======
Vundle           https://github.com/gmarik/vundle                    Plugin Manager

NerdTree         https://github.com/scrooloose/nerdtree              Filesystem Explorer

NerdTreeTabs     https://github.com/jistr/vim-nerdtree-tabs          NerdTree with tabs

Tommorow-Dark    https://github.com/chriskempson/vim-tomorrow-theme  Colorscheme

NerdCommenter    https://github.com/scrooloose/nerdcommenter         Code commenting

Syntastic        https://github.com/scrooloose/syntastic             Syntax checking

Powerline        https://github.com/Lokaltog/vim-powerline           Prettier status line

Powerline Hax    https://github.com/zeekay/vim-powerline-hax         Fixes the issue I was having with Syntastic and Powerline

IndentPython     https://github.com/vim-scripts/indentpython.vim     Pep8 Indentation

CTags Generation https://github.com/vim-scripts/indexer.tar.gz      Automatic CTag generation and update
