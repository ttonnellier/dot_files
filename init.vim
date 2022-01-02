" auto-install vim-plug
let s:vimplg = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:vimplg))
    execute '!curl -fLo ' s:vimplg ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
endif
call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'vim-scripts/diffchanges.vim'
call plug#end()

"syntax
syntax enable
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete
set autoindent
set backspace=indent,eol,start

"performance
set complete-=i

"colorscheme
let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
colorscheme vim-monokai-tasty                         " set the colorscheme
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
set shiftround

"look
set number relativenumber
set showcmd
set cursorline
set showmatch

"text rendering
set display+=lastline
set sidescrolloff=5
set scrolloff=1
set wrap

"search
set path+=**
set wildmenu
set incsearch
set hlsearch
set smartcase
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
"
"fold
set foldenable
set foldlevelstart=6
set foldnestmax=10
set foldmethod=indent

"undo
let s:unddir = stdpath('data') . '/vimundo/'
echo s:unddir
if empty(glob(s:unddir))
    execute '!mkdir ' s:unddir
endif
let &undodir=s:unddir
set undofile

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

set autoread

"auto spell for markdown and tex
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell

"auto remove trailing spacews when saving a file
autocmd BufWritePre * :%s/\s\+$//e

"shortcut for paste option
inoremap <F3> <esc>:set paste!<cr>i
nnoremap <F3> :set paste!<cr>

"clang-format shortcut
if has('python')
  map <C-I> :pyf /home/tibo/Documents/code/clang-format.py<cr>
  imap <C-I> <c-o>:pyf /home/tibo/Documents/code/clang-format.py<cr>
elseif has('python3')
  map <C-I> :py3f /home/tibo/Documents/code/clang-format.py<cr>
  imap <C-I> <c-o>:py3f /home/tibo/Documents/code/clang-format.py<cr>
endif

"nvim terminal exit
tnoremap <Esc> <C-\><C-n>

"name of highlight
command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')

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
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

-- Manual add rust_hdl server
if not configs.rust_hdl then
  configs.rust_hdl = {
    default_config = {
      cmd = {'/home/tibo/Documents/code/rust_hdl/target/release/vhdl_ls'};
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
  buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
  buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
  buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
  buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
  buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>',                                 opts)
  buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         opts)
  buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'texlab', 'rust_hdl' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

"dap
lua << EOF
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
local opt = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>dc',  '<cmd>lua require"dap".continue()<CR>',          opt)
vim.api.nvim_set_keymap('n', '<leader>dd',  '<cmd>lua require"dap".terminate()<CR>',         opt)
vim.api.nvim_set_keymap('n', '<leader>dr',  '<cmd>lua require"dap".repl.toggle()<CR>',       opt)
vim.api.nvim_set_keymap('n', '<leader>dK',  '<cmd>lua require"dap.ui.widgets".hover()<CR>',  opt)
vim.api.nvim_set_keymap('n', '<leader>dt',  '<cmd>lua require"dap".toggle_breakpoint()<CR>', opt)
vim.api.nvim_set_keymap('n', '<leader>dso', '<cmd>lua require"dap".step_over()<CR>',         opt)
vim.api.nvim_set_keymap('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>',         opt)
vim.api.nvim_set_keymap('n', '<leader>dl',  '<cmd>lua require"dap".run_last()<CR>',          opt)
vim.api.nvim_set_keymap('n', '<leader>ds',  '<cmd>lua require"dapui".setup()<CR>',           opt)
vim.api.nvim_set_keymap('n', '<leader>do',  '<cmd>lua require"dapui".open()<CR>',            opt)
vim.api.nvim_set_keymap('n', '<leader>dx',  '<cmd>lua require"dapui".close()<CR>',           opt)
vim.api.nvim_set_keymap('n', '<leader>de',  '<cmd>lua require"dapui".eval()<CR>',            opt)
EOF
