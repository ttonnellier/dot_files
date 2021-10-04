" auto-install vim-plug
let s:vimplg = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:vimplg))
    execute '!curl -fLo ' s:vimplg ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
endif
call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'junegunn/vim-easy-align'
Plug 'neovim/nvim-lspconfig'
call plug#end()

"syntax
syntax enable
filetype plugin on
filetype indent on
set autoindent

"colorscheme
let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
colorscheme vim-monokai-tasty                         " set the colorscheme
let g:lightline = { 'colorscheme': 'monokai_tasty' }  " lightline theme

"tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

"look
set number relativenumber
set showcmd
set cursorline
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
let s:unddir = stdpath('data') . '/vimundo/'
if empty(glob(s:unddir))
    execute '!mkdir ' s:unddir
endif
set undodir=s:unddir
set undofile

"invisible char
set listchars=eol:↲,tab:→\ ,trail:•,extends:⟩,precedes:⟨,space:·
highlight SpecialKey ctermfg=236
highlight NonText ctermfg=236
set list

"when reopen a file, jump where we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

"auto spell for markdown
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell

"auto remove trailing spacews when saving a file
autocmd BufWritePre * :%s/\s\+$//e

"shortcut for paste option
inoremap <F3> <esc>:set paste!<cr>i
nnoremap <F3> :set paste!<cr>

"nvim terminal exit
tnoremap <Esc> <C-\><C-n>

"plugin easy align
""start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""extend alignment rules for VHDL
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

"lsp
lua << EOF
-- require'lspconfig'.texlab.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'texlab' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
