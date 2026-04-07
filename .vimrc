" Set colorcheme
colorscheme industry
set background=dark

" Set command window height
set cmdheight=1

" Enable relative line numbers
set relativenumber
set number

" Allow hidden buffers with unsaved changes
set hidden

" Enable long string highlighting
set synmaxcol=10000

" Automatically center on search
nnoremap n nzzzv
nnoremap N Nzzzv

" Disable swap files
set noswapfile

" Set ripgrep as default program
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Set default make program
set makeprg=./build.sh

" Netrw settings 
let g:netrw_banner = 0       " Disable header
let g:netrw_liststyle = 3    " Tree style view
let g:netrw_browse_split = 4 " Opens selected files in previous window
let g:netrw_winsize = 25     " Side bar width
let g:netrw_altv = 1         " Alternate Vsplit behaviour
nnoremap <leader>e :Lexplore!<CR>

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

" Enable optional plugin
packadd nohlsearch
packadd comment
packadd hlyank
packadd! matchit
packadd! editorconfig

" Enable mouse mode
set mouse=a

" Do incremental search
set incsearch

" Show a few lines of context around the cursor
set scrolloff=5

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

" Setup omnicomplete for specific filetypes
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType vim setlocal omnifunc=vimcomplete#Complete
autocmd FileType python setlocal omnifunc=python3complete#Complete

" Auto update tags
nnoremap <leader>t :!ctaggs -R .<CR>

" Open function definition in preview window
nnoremap <leader>p :ptag <C-R><C-W><CR>

" Remap < and > to retain visual selection after indenting/unindenting
vnoremap < <gv
vnoremap > >gv

" Set no expandtab for makefiles and tsv files
augroup Makefiles
    autocmd! * <buffer>
    autocmd BufNewFile,BufRead Makefile,*.tsv setlocal noexpandtab
augroup END

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
set wildoptions=pum,fuzzy
set wildignorecase

" Completion options
set autocomplete
set complete=o
set completeopt=fuzzy,menuone,popup,noselect

" Automatically read files when changes detected
set autoread

" Automatically change cwd to the directory of the current file
set autochdir

" Show non-visible characters
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<

" Quickfix remaps
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

" Gvim options
set guioptions-=e " Use text tabs instead of GUI tabs
set guioptions-=r " Remove right scrollbar
set guioptions-=L " Remove left scrollbar
set guioptions-=m " Remove menu bar
set guioptions-=T " Remove tool bar
set guioptions+=c " TUI dialogs

" Font size hotkeys for GVIM
let g:my_font_size = 16
let &guifont = 'Monospace ' . g:my_font_size

" Font resizing for Gvim
nnoremap <C-=> :call AdjustFontSize(1)<CR>
nnoremap <C-_> :call AdjustFontSize(-1)<CR>

function! AdjustFontSize(amount)
    let g:my_font_size += a:amount
    let &guifont = 'Monospace ' . g:my_font_size
endfunction

" DBext profiles
let g:dbext_default_profile_SQLite_osfi = 'type=DBI:driver=SQLite:conn_parms=dbname=/home/mmarcoux/personal/osfi/data.db'
let g:omni_sql_default_replace_compl_type = 'column'
