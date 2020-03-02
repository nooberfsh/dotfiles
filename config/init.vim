""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/LeaderF-marks'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-grepper'

Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kassio/neoterm'

"colors
Plug 'joshdick/onedark.vim'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   common
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ";"

set nu
" Buffer should still exist if window is closed
set hidden                      
syntax enable
set autoread
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"https://stackoverflow.com/questions/18024842/vimrc-file-takes-longer-and-longer-to-reload
augroup auto_update_vimrc
  	autocmd!
  	autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup end

noremap <Leader>v :source $MYVIMRC<CR>
nnoremap <Leader>e :e $MYVIMRC<CR>

set scrolloff=8

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set ignorecase
set smartcase 
set hlsearch
set incsearch

" toggle hightlight
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" substitute
nnoremap <Leader>su :%s/\<<C-r><C-w>\>//g<Left><Left>

inoremap <c-s> <Esc>:update<CR>
nnoremap <c-s> <Esc>:update<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.bk$']
let NERDTreeShowHidden=1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ycm
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt-=preview



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 air-line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set termguicolors
colorscheme onedark
let g:airline_theme='onedark'

hi Search cterm=NONE ctermfg=grey ctermbg=blue



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            windows and terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set splitright
set splitbelow

"exit input mode and back to terminal mode
tnoremap <Esc> <C-\><C-n>

"vertical split
nnoremap <F2> :vs<CR>
inoremap <F2> :vs<CR>

"horizontal split
nnoremap <Leader><F2> :sp<CR>
inoremap <Leader><F2> :sp<CR>

"close current window
tmap <F4> <ESC>:q<CR>
nnoremap <F4> <ESC>:q<CR>
inoremap <F4> <ESC>:q<CR>

let g:neoterm_autoinsert = 1
let g:neoterm_open_in_all_tabs = 0
let g:neoterm_default_mod = 'vertical'
nnoremap <F1> :Ttoggle<CR>
inoremap <F1> :Ttoggle<CR>
tnoremap <F1> <Esc>:Ttoggle<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   leaderf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = '<Leader>ff'
let g:Lf_ShortcutB = '<Leader>fb'
nnoremap <Leader>ff :LeaderfFile<CR>
nnoremap <Leader>fb :LeaderfBuffer<CR>
nnoremap <Leader>fu :LeaderfMru<CR>
nnoremap <Leader>ft :LeaderfTag<CR>
nnoremap <Leader>fr :LeaderfFunction<CR>
nnoremap <Leader>fm :LeaderfMarks<CR>


let g:Lf_WorkingDirectoryMode = 'ac'
"let g:Lf_DefaultMode = 'FullPath'
let g:Lf_CacheDirectory = $HOME.'/.cache/nvim'
let g:Lf_ShowHidden = 1
let g:Lf_MruFileExclude = ['*.txt']
let g:Lf_MruWildIgnore = {
            \ 'dir': ['~/.local/share/nvim'],
            \ 'file': ['*.txt']
            \}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   grep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>* :Grepper -tool rg -open -switch -cword -noprompt<CR>
nnoremap <Leader>8 :Grepper -tool rg -open -switch -buffer -cword -noprompt<CR>
nnoremap <Leader>ss :Grepper -tool rg -open -switch -query 
nnoremap <Leader>sb :Grepper -tool rg -open -switch -buffer -query 




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=100

