set nocompatible
set number

syntax on

" smart case in search. Both of the following statements are needed
set ignorecase
set smartcase


set smartindent

"Recognize file type to activate syntax highlighting, set options, etc.
filetype on

filetype plugin indent on

"Show existing tabs with 4 spaces
" set tabstop=2

"When indenting with '>', use 4 spaces
" set shiftwidth=2

"On pressing tab, insert 4 spaces
" set expandtab

"Highlight search results
set hlsearch

"Let Delete key work as expected
set backspace=indent,eol,start

"display line and column numbers on bottom left corner
set ruler


" Modify status line
set statusline=%f       " Path to the file
set statusline+=\ %2c   " Cursor position in row
set statusline+=%=      " Switch to the right side
set statusline+=%l      " Current line
set statusline+=/       " Separator
set statusline+=%L      " Total lines
set laststatus=2        " Make statusline visible https://stackoverflow.com/a/40191092/2654104



"call pathogen#infect()
"" 1 important ----------------------------------------------------------------
"set nocompatible
"" 2 moving around, searching, and patterns -----------------------------------
"set incsearch
"set smartcase
"set ignorecase
"set wrapscan
"" 3 tags
"" 4 displaying text
"set scrolloff=2
"set linebreak
"set number
"" 5 syntax, highlighting and spelling
"set hlsearch
"set background=dark
"" 6 multiple windows
"" 18 reading and writing files
"set nobackup
"" 19 the swap file
"set noswapfile
"" 20 command line editing
"set noundofile



""enable filetype detection and plugin and indent loading
"filetype plugin indent on

"filetype off                  " required

"" Enable folding with spacebar
"nnoremap <space> za

au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=120
au BufNewfile,BufRead *.py set expandtab
au BufNewfile,BufRead *.py set autoindent
au BufNewfile,BufRead *.py set fileformat=unix
"" au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

"au BufNewFile,BufRead *.rb set tabstop=2
"au BufNewFile,BufRead *.rb set softtabstop=2
"au BufNewFile,BufRead *.rb set shiftwidth=2
"au BufNewfile,BufRead *.rb set expandtab
"au BufNewfile,BufRead *.rb set autoindent
"au BufNewfile,BufRead *.rb set fileformat=unix

"au BufNewFile,BufRead *.poi set tabstop=4
"au BufNewFile,BufRead *.poi set softtabstop=4
"au BufNewFile,BufRead *.poi set shiftwidth=4
"au BufNewFIle,BufRead *.poi set expandtab

au BufNewFile,BufRead *.txt set tabstop=2
au BufNewFile,BufRead *.txt set softtabstop=2
au BufNewFile,BufRead *.txt set shiftwidth=2
au BufNewfile,BufRead *.txt set expandtab
au BufNewfile,BufRead *.txt set autoindent
au BufNewfile,BufRead *.txt set fileformat=unix

"set number

""display line and column numbers on bottom left corner
"set ruler

"" insert timestamps
"imap <F5> <C-R>=strftime("%F    %a")<CR>
"imap <F6> <C-R>=strftime("%F %a %H:%M")<CR>

""Disable bells http://vim.wikia.com/wiki/Disable_beeping
"set noerrorbells visualbell t_vb=

""smart line wrapping of itemized lines
"set ai

""use system clipboard
"set clipboard=unnamed

"" syntax highlighting
"syntax on

""disable backspace in Insert mode
"" http://stackoverflow.com/questions/13741237/how-to-disable-backspace-and-delete-keys-in-vim
"" :inoremap <BS> <Nop>
"" :inoremap <Del> <Nop>
"set backspace=indent,eol,start

""inoremap kj <esc>
""inoremap <esc> <nop>

"" autocmd TextChanged,TextChangedI <buffer> write

"set hlsearch
"set incsearch

"set statusline=%f		" Path to the file
"set statusline+=\ %2c		" Cursor position in row
"set statusline+=%=		" Switch to the right side
"set statusline+=%l		" Current line
"set statusline+=/ 		" Separator
"set statusline+=%L		" Total lines


"" select in block visual mode ignoring initial whitespace
"" nnoremap V ^v$<C-v>

"let mapleader = ","

"nmap <leader>d i<C-R>=strftime("%Y-%m-%d %a")<CR><Esc>
"imap <leader>d <C-R>=strftime("%Y-%m-%d %a")<CR>

"nnoremap <leader>l :set list<enter>
"nnoremap <leader>nl :set nolist<enter>

"nnoremap <leader>p :set paste<enter>
"nnoremap <leader>np :set nopaste<enter>

"" http://stackoverflow.com/questions/15550100/exit-visual-mode-without-delay
"set timeoutlen=1000 ttimeoutlen=0

"set wildmenu

"set scrolloff=3
