colorscheme molokai
syntax enable

set tabstop=4  
set softtabstop=4
set expandtab 

set number
set showcmd 
set cursorline
set wildmenu
set lazyredraw
set showmatch

set clipboard=unnamedplus

set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set foldnestmax=10 
set foldmethod=syntax

set listchars=eol:↲,tab:→\ ,trail:•,extends:⟩,precedes:⟨,space:·
highlight SpecialKey ctermfg=236
highlight NonText ctermfg=236
set list

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif
