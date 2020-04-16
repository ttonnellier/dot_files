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

set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set foldnestmax=10 
set foldmethod=syntax

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
