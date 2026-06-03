"sd --- DISPLAY AND NAVIGATION ---
" Enable syntax highlighting
syntax on
" Show line numbers for structural navigation
set number
" Highlight the current screen line for better focus
set cursorline
" Show cursor position coordinates in the bottom right
set ruler

" --- SEARCH OPTIMIZATIONS ---
" Highlight all matches during search
set hlsearch
" Jump to matches incrementally while typing the query
set incsearch
" Ignore case when searching
set ignorecase
" Override ignorecase if the search query contains uppercase letters
set smartcase

" --- INDENTATION AND TABS ---
" Convert tabs to spaces (KISS standard)
set expandtab
" Number of spaces that a <Tab> counts for
set tabstop=4
" Number of spaces data is indented with using navigation commands
set shiftwidth=4
" Copy indent from current line when starting a new one
set autoindent

" --- SYSTEM INTEGRATION AND PERFORMANCE ---
" Fix backspace behavior so it works like in regular editors
set backspace=indent,eol,start
" Disable swap and backup files to keep directories pristine
set nobackup
set noswapfile
" Set encoding standard
set encoding=utf-8

" --- SYSTEM CLIPBOARD INTEGRATION ---
" Configure Vim to use the system clipboard as the default register
set clipboard=unnamedplus


" --- COLOR AND CONTRAST OPTIMIZATIONS ---
" Tell Vim it is running inside a dark terminal emulator to optimize default colors
set background=dark

" Force 256 color mode support
set t_Co=256

" Explicitly override String color for high readability on dark/purple backgrounds
" ctermfg=113 is a clean, bright lime green; change to 11 for bright yellow if preferred
highlight String ctermfg=113