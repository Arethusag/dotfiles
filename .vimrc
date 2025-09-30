" Set colorcheme
colorscheme lunaperche
set background=dark

" Set command window height
set cmdheight=1

" Enable line numbers
set number

" Disable swap files
set noswapfile

" Set ripgrep as default program
set grepprg=rg\ --vimgrep

" Set default make program
set makeprg=./build.sh

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

" Persist undo history
set undofile
set undodir=~/.vim/undo/
set undolevels=10000

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
nnoremap <leader>t :!ctags -R .<CR>

" Open function definition in preview window
nnoremap <leader>p :ptag <C-R><C-W><CR>

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
set statusline=%f\ (%{&fileencoding!=''?&fileencoding:&encoding})\ %=[%{line('.')},%{col('.')}\]

" Clang formatter setup
autocmd FileType c nnoremap <buffer> gq :py3f /usr/share/clang/clang-format.py<CR>
autocmd FileType c vnoremap <buffer> gq :py3f /usr/share/clang/clang-format.py<CR>

" Autoformat on save
function! Formatonsave()
    let l:formatdiff = 1
    py3f /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.c call Formatonsave()

" Wildmenu config
set wildmenu
set wildmode=full
set wildoptions=pum
set wildignorecase

" Automatically change cwd to the directory of the current file
set autochdir

" Show non-visible characters
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<
