call plug#begin('~/.local/share/nvim/plugged')

" Dracula colorscheme
" Plug 'dracula/vim', {'as': 'dracula'}

" Catppuccin colorscheme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Autocomplete engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Autocomplete engine for python
" Plug 'zchee/deoplete-jedi'

" Linter
Plug 'neomake/neomake'

" Rust syntax hightlighting
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'

call plug#end()

function! InsertHTMLTemplate()
    return 
        \ "<!doctype html>\n"
        \. "<html lang=\"en\">\n"
        \. "<head>\n"
        \. "        <meta charset=\"utf-8\">\n"
        \. "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
        \. "        <title>Title</title>\n"
        \. "    </head>\n"
        \. "    <body>\n"
        \. "        <h1>Hello, world!</h1>\n"
        \. "    </body>\n"
        \. "</html>\n"
endfunction

iabbrev <expr> html# InsertHTMLTemplate()

" Enable code completion on startup
let g:deoplete#enable_at_startup = 1

" Enable syntax highlighting for python3
let g:python_highlight_all = 1

" Autoclosing brackets, quotes, parentheses, braces
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Ramap moving between splits to ctr+h/l/j/k
noremap <C-l> :wincmd l<CR>
noremap <C-h> :wincmd h<CR> 
noremap <C-j> :wincmd j<CR>
noremap <C-k> :wincmd k<CR>

" Do not wrap overflow lines
set nowrap

" Enable syntax highlighting and catppuccin theme
syntax enable
filetype plugin indent on
colorscheme catppuccin

" Setting tab autoindent and width
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Do not make a swap file for eveything I open
set noswapfile

" Add line numbers for easier navigation
set number 

" Used to search through subdirectory when using :find filename
set path+=**
set wildmenu

" Color column 80, which is standard line length
set colorcolumn=80

lua << EOF
    local lspconfig = require('lspconfig')

    local servers = { 'rust_analyzer' }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {}
    end
EOF
