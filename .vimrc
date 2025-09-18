" Set colorcheme
colorscheme default

" Enable line numbers
set number

" Disable swap files
set noswapfile

" Disable netrw header
let g:netrw_banner = 0

" Enable syntax highlighting
syntax enable

" Disable auto commenting
autocmd FileType * setlocal formatoptions-=cro

" Set indent to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable filetype detection, plugins, and indentation rules
filetype on
filetype plugin on
filetype indent on

" Enable optional comment plugin, uses 'gc' as binding
packadd nohlsearch
packadd comment
packadd! matchit
packadd! editorconfig

" Enable mouse mode
set mouse=a

" Set indent style
autocmd FileType c set cindent

" Set folding
set foldmethod=syntax

let &t_SI = "\e[5 q"      " Vertical line cursor in insert mode
let &t_SR = "\e[4 q"      " Underscore cursor in replace mode
let &t_EI = "\e[2 q"      " Block cursor in normal mode

" Setup omnicomplete for c files, CTRL+X CTRL+O
autocmd FileType c setlocal omnifunc=ccomplete#Complete

" Auto update tags
nnoremap <leader>ut :!ctags -R .<CR>

" Remap < and > to retain visual selection after indenting/unindenting
vnoremap < <gv
vnoremap > >gv

" Set no expandtab for makefiles
augroup Makefiles
    autocmd! * <buffer>
    autocmd BufNewFile,BufRead Makefile setlocal noexpandtab
augroup END

" Fix backspace in insert mode
set backspace=2

" Reduce delay in millisecond for mappings to trigger, default is 1000
set timeoutlen=300

" Always show the status bar
set laststatus=2

" Custom status line to show filename and cursor position
set statusline=%f%m%r%h%w\ %=[%{line('.')},%{col('.')}]
