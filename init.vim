" auto-install vim-plug
let s:vimplg = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:vimplg))
    execute '!curl -fLo ' s:vimplg ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"lazy loading function
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
"Plug 'liuchengxu/space-vim-theme'
Plug 'tanvirtin/monokai.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neopairs.vim'
"Plug 'deoplete-plugins/deoplete-lsp', { 'for': ['python', 'latex', 'tex']}
Plug 'neovim/nvim-lspconfig', Cond(!exists('g:vscode'))
"Plug 'nvim-lua/completion-nvim', Cond(!exists('g:vscode'))
"Plug 'nvim-lua/lsp-status.nvim', Cond(!exists('g:vscode'))
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'daeyun/vim-matlab', { 'do': ':UpdateRemotePlugins' }
Plug 'alemuller/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
call plug#end()

"syntax
syntax on
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete
set updatetime=300
set completeopt=menuone
set completeopt+=noinsert
set completeopt-=preview
set autoindent

"splits location
set splitbelow
set splitright

"colorscheme
colorscheme monokai_pro
hi vhdlTSType guifg=#61c4ef
"colorscheme space_vim_theme
let g:lightline = {
\     'active': {
\         'left': [ ['mode', 'paste' ],
\                   ['readonly', 'filename', 'modified'],
\                   ['gitbranch']],
\         'right': [['lineinfo'],
\                   ['percent'],
\                   ['fileformat', 'fileencoding']]
\     },
\     'component_function': {
\         'gitbranch': 'gitbranch#name'
\     },
\     'colorscheme': 'PaperColor',
\ }
set noshowmode

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
set smartcase

"fold
"set foldenable
"set foldlevelstart=10
"set foldnestmax=10
set foldmethod=indent

"undo
let s:unddir = stdpath('data') . '/vimundo/'
echo s:unddir
if empty(glob(s:unddir))
    execute '!mkdir ' s:unddir
endif
let &undodir=s:unddir
set undofile
if exists('g:vscode')
    nnoremap <silent> u :<C-u>call VSCodeNotify('undo')<CR>
    nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>
endif

"invisible char
set listchars=eol:↲,tab:→\ ,trail:•,extends:⟩,precedes:⟨,space:·
highlight SpecialKey ctermfg=237
highlight NonText ctermfg=237
highlight WhiteSpace ctermfg=237
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

"name of highlight
command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')

"plugins

""easy align
"""start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""extend alignment rules for VHDL
let g:easy_align_delimiters = {
\ ':': {
\     'pattern': ':',
\     'left_margin': 0,
\     'right_margin': 1,
\     'stick_to_left': 0 },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 1 },
\ }

if !exists('g:vscode')

""deoplete
let g:deoplete#enable_at_startup = 1

""snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

""matlab-vim
let g:matlab_auto_mappings = 0

""treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"vhdl", "python", "cpp", "latex", "vim"},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = false,
    },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

""lsp
lua << EOF
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

-- Manual add rust_hdl server
if not configs.rust_hdl then
  configs.rust_hdl = {
    default_config = {
      cmd = {'/home/storm/Documents/code/rust_hdl/target/release/vhdl_ls'};
      filetypes = { "vhdl" };
      root_dir = function(fname)
        return lspconfig.util.root_pattern('vhdl_ls.toml')(fname)
      end;
      settings = {};
    };
  }
end
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
local servers = {'clangd', 'pyright', 'texlab', 'rust_hdl' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
endif
