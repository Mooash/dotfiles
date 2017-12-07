" Syntax highlighting for files
syntax on
let &t_Co=256
" Chose our default color scheme
colorscheme desert
" Line numbers
set number
hi comment ctermfg=6
set background=dark

" Auto detect file type
filetype on

" Create vimrc autocmd group and remove any existing vimrc autocmds,
" in case .vimrc is re-sourced.
augroup vimrc
  autocmd!
augroup END

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>


" When editing a file, always jump to the last known cursor position. Don't do
" it for commit messages, when the position is invalid, or when inside an event
" handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Start vim-plug
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', {'for': 'go'}
Plug 'mustache/vim-mustache-handlebars'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-lua-ftplugin'
Plug 'pearofducks/ansible-vim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'morhetz/gruvbox'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
"Plug 'chase/vim-ansible-yaml'

" Add plugins to &runtimepath
call plug#end()
" End vim-plug

" Activeate pathogen
execute pathogen#infect()

" Filetypes
if has("autocmd")
  filetype plugin indent on " automatic per-language indentation
  " filetype detection
  "" see http://beerpla.net/2008/04/02/how-to-add-a-vim-file-extension-to-syntax-highlighting/
  augroup filenames
    autocmd BufRead,BufNewFile *.go   setlocal filetype=go
    autocmd BufRead,BufNewFile *.md   setlocal filetype=markdown
    autocmd BufRead,BufNewFile *.json setlocal filetype=json
  augroup end
endif

" highlighting for some of our configs
au BufReadPost ~/.ssh/conf.d/* setlocal filetype=sshconfig

" Spell checking
"set complete+=kspell
"autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_au

" Don't let the puppet plugin do auto alignment
let g:puppet_align_hashes = 0

" override iskeyword from the puppet bundle to allow "regular" word movement
" TODO noautoindent isn't enough to stop stupid indenting with comments, need
" to look into smartindent and the puppet module
au BufReadPost *.pp setlocal iskeyword+=^:,^- noautoindent nosmartindent

" Always show status bar
set laststatus=2
let g:airline_powerline_fonts = 1
" We need set our font MacVim
set guifont=Menlo\ for\ Powerline

" Include local config if it exists
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

set shell=/bin/bash
