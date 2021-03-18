call plug#begin('$HOME/.config/nvim') 
" call plug#begin('C:\Users\mateuszu\AppData\Local\nvim') 
    " Fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Vim rooter
    Plug 'airblade/vim-rooter'

    " Tree
    Plug 'preservim/nerdtree'

    " Gui
    Plug 'itchyny/lightline.vim' 
    Plug 'machakann/vim-highlightedyank'

    " Semantic language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Syntactic language support
    Plug 'cespare/vim-toml'
    Plug 'stephpy/vim-yaml'
    Plug 'rust-lang/rust.vim'
    Plug 'plasticboy/vim-markdown'
    Plug 'blueyed/smarty.vim'

    " Show errors in code
    Plug 'dense-analysis/ale'

    " Theme
    Plug 'tomasiser/vim-code-dark'
    
    " Bracket autopairs
    Plug 'jiangmiao/auto-pairs'

    " Blade support
    Plug 'jwalton512/vim-blade'
call plug#end()

let mapleader = "\<Space>"

" NerdTree
nnoremap <C-t> :NERDTreeToggle<CR>

" turn relative line numbers on
:set number relativenumber
:set nu rnu

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard^=unnamed,unnamedplus
syntax on

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile


" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Quick-save
nmap <leader>w :w<CR>

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Set color sheme
colorscheme codedark
let g:airline_theme = 'codedark'

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" Edid xaml as XML
autocmd BufRead,BufNewFile *.xaml :set filetype=xml

" Fzf configuration
noremap <leader>s :Rg<space>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <C-p> :FZF<CR>

" Set ripgrep as default on windows
silent !setx FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob . 2> nul'

" Remember last position in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Coc go to definition
nmap <silent> gd <Plug>(coc-definition)
