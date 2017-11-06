"""""""""""""""""""""""""""""""""""""""""""""""""""""
"plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-syntastic/syntastic'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'rdnetto/YCM-Generator'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"common
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
let g:mapleader = ','

set nu
syntax enable

augroup reload_vimrc " {
	    autocmd!
	        autocmd BufWritePost $MYVIMRC source $MYVIMRC
	augroup END " nerdtree}

map <Leader> e: e $MYVIMRC <CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set scrolloff=7

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set ignorecase
set smartcase 

inoremap <c-s> <Esc>:update<CR>
nnoremap <c-s> <Esc>:update<CR>

set autoread



"""""""""""""""""""""""""""""""""""""""""""""""""""""
"rust
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.bk$']



"""""""""""""""""""""""""""""""""""""""""""""""""""""
"ycm
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_rust_src_path = '~/.multirust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
let g:ycm_confirm_extra_conf = 0

nmap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>gr :YcmCompleter GoToReferences<CR>

nmap <leader>yg :YcmGenerateConfig --verbose<CR>
nmap <leader>yr :YcmRestartServer<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"air-line
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"color
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme solarized
let g:airline_theme= 'solarized'
let g:airline_solarized_bg='dark'



"""""""""""""""""""""""""""""""""""""""""""""""""""""
"syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nmap <leader>c :SyntasticCheck cargo<CR>

let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }
