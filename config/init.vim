""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

"completion
Plug 'Valloric/YouCompleteMe'
"lint
Plug 'w0rp/ale'
"rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
"go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/LeaderF-marks'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-grepper'
Plug 'romainl/vim-qf'

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
"                                   rust
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup rust
	autocmd!
	autocmd FileType rust nmap <Leader>gd <Plug>(rust-def)
	autocmd FileType rust nmap <Leader>gs <Plug>(rust-def-vertical)
	autocmd FileType rust nmap <Leader>gx <Plug>(rust-def-split)
	autocmd FileType rust nmap <Leader>gc <Plug>(rust-doc)
augroup end


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   golang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>
augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <F6> :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <F7>  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <F5>  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <F8> <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef
  autocmd FileType go nmap <Leader>gd <Plug>(go-def)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>gs <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>gc <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction



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
"                                   quickfix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType qf call AdjustWindowHeight(8, 16)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

nmap <F3> <Plug>(qf_qf_toggle)
nmap <Leader><F3> <Plug>(qf_loc_toggle)
noremap <Leader>n :cnext<CR>
noremap <Leader>p :cprevious<CR>


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
"                                   ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_linters = {'rust': ['rls']}
let b:ale_fixers  = {'rust': ['rustfmt']}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=100

