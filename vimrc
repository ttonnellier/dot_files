colorscheme molokai
syntax enable
filetype plugin on
filetype indent on
set autoindent

set clipboard=unnamedplus

"tabs
set shiftwidth=4
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
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
"let g:netrw_liststyle=3     " tree view
"let g:netrw_altv = 1
"let g:netrw_winsize = 15
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"snippets
nnoremap <leader>html :-1read $HOME/.vim/skeleton.html<CR>3jwf>a
nnoremap <leader>tstmd :-1read $HOME/.vim/skeletons/skeleton_test_report.md<CR>

"when reopen a file, jump where we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

"auto spell for markdown
autocmd FileType markdown setlocal spell

"auto remove trailing spacews when saving a file
autocmd BufWritePre * :%s/\s\+$//e

"auto close braces
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap (<CR> (<CR>)<ESC>O
"inoremap [ []<left>
"inoremap [<CR> [<CR>]<ESC>O
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O

"shortcut for paste option
inoremap <F3> <esc>:set paste!<cr>i
nnoremap <F3> :set paste!<cr>

"nvim specific
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

"plugin
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Extending alignment rules for VHDL
let g:easy_align_delimiters = {
\ ':': {
\     'pattern': ':',
\     'left_margin': 1,
\     'right_margin': 1,
\     'stick_to_left': 0 },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 1 },
\ }
