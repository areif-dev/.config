call plug#begin('~/.local/share/nvim/plugged')

" Dracula colorscheme
" Plug 'dracula/vim', {'as': 'dracula'}

" Catppuccin colorscheme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Rust syntax hightlighting
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'

" Autocomplete engine
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Code snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

set completeopt=menu,menuone,noselect

" Autoclosing brackets, quotes, parentheses, braces
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
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

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local servers = { 'rust_analyzer' }
  for _, lsp in ipairs(servers) do
      require('lspconfig')[lsp].setup {
        capabilities = capabilities
      }
  end
EOF
