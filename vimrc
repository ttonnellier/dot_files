colorscheme molokai
syntax enable
filetype plugin on
filetype indent on
set autoindent

set clipboard=unnamedplus

"tabs
set tabstop=4  
set softtabstop=4
set expandtab 

"look
set number relativenumber
set showcmd 
set cursorline
"set lazyredraw
set showmatch
set nowrap

"search
set path+=**
set wildmenu
set incsearch
set hlsearch

"fold
set foldenable
set foldlevelstart=10
set foldnestmax=10 
set foldmethod=indent

"undo
set undofile
set undodir=$HOME/.vim/vimundo/

"invidible char
set listchars=eol:↲,tab:→\ ,trail:•,extends:⟩,precedes:⟨,space:·
highlight SpecialKey ctermfg=236
highlight NonText ctermfg=236
set list

"file browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"snippets
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

"when reopen a file, jump where we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

"auto close braces 
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap (<CR> (<CR>)<ESC>O<TAB>
inoremap [ []<left>
inoremap [<CR> [<CR>]<ESC>O<TAB>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O<TAB>
