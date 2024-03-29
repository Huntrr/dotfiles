" Hunter Lightman's vimrc
set nocompatible
let mapleader=" "
set mouse=a

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" always copy to system clipboard
set clipboard=unnamedplus

" -------
" PLUGINS
" -------
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'jacoborus/tender.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/argtextobj.vim' " Adds the ia and aa text objects
Plug 'michaeljsmith/vim-indent-object' " Adds the ii and ai text objects
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround' " Adds s selector
Plug 'scrooloose/nerdcommenter' " Adds <LEADER>cc
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-textobj-sentence'
Plug 'sheerun/vim-polyglot'
Plug 'deris/vim-shot-f'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'vim-scripts/a.vim'
Plug 'LucHermitte/lh-vim-lib'

Plug 'davidhalter/jedi-vim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'luchermitte/vimfold4c', { 'for': 'cpp' }

"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
call plug#end()
" remember to run :PlugInstall!

let g:ale_linters = {
      \ 'c': ['clang-format', 'clang'],
      \ 'cpp': ['clang-format', 'clang'],
      \ 'javascript': ['standard', 'eslint'],
      \ 'python': ['mypy', 'flake8'],
      \ }

let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1

" disable some Jedi maps
let g:jedi#rename_command = ""

set timeoutlen=1000 ttimeoutlen=0

" coc.nvim configurations
"set statusline^=%{coc#status()}
"set hidden
"set cmdheight=2
"set updatetime=300
"set shortmess+=c
"if has("nvim")
  "set signcolumn=yes
"endif
"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction

" ------------
" BASIC CONFIG
" ------------
filetype plugin on
filetype indent on
set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set cindent
set autoread
set showbreak=▸
set laststatus=2 " show statusline always
set cursorline
hi CursorLine guibg=#6d6d6d
set showmatch " show matching paren
set wildmenu

" python/html tab stops
au FileType python setl sw=4 ts=4
au FileType html setl sw=4 ts=4
au FileType md setl sw=4 ts=4

" Line length
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" ----------
" APPEARANCE
" ----------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
  set background=dark
  colorscheme tender
endif

if (has("termguicolors"))
  set termguicolors
endif

hi VertSplit guifg=Grey
hi Visual term=reverse cterm=reverse guibg=Grey

set showtabline=2

"function! CocCurrentFunction()
    "return get(b:, 'coc_current_function', '')
"endfunction

"function! CocStatus()
    "return get(g:, 'coc_status', '')
"endfunction

let g:lightline = { 
      \ 'colorscheme': 'tender',
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 1,
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ],
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \   'buffers': 'tabsel',
      \ },
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'readonly', 'filename', 'modified' ],
      \     [ 'cocstatus', 'currentfunction' ],
      \   ],
      \   'right': [
      \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \   ],
      \ },
      \ }

" Don't use Ex mode, use Q for formatting
map Q gq

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap Z za
set foldmethod=indent


" --------
" MAPPINGS
" --------
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch off search highlight until next search (clear the highlight)
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Switches between header and source files
nnoremap <Leader>s :A<CR>
nnoremap <Leader>S :AS<CR>

" nvim terminal
if has("nvim")
  :nnoremap <C-t> :split<CR>:resize 20<CR>:terminal<CR>
  :tnoremap <C-n> <C-\><C-n>
  :set shell=zsh
endif

" Splits
nnoremap <Leader>" :sp<CR>
nnoremap <Leader>% :vsp<CR>

" Ctags
nmap <C-c> <C-t>Actags -R --fields=+S --exclude="bazel-*" --exclude=".git"<CR>

" Autcomplete
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:goto_definition()
  "if CocAction('jumpDefinition')
    "return v:true
  "endif
  execute "normal \<C-]>"
endfunction

" coc
"inoremap <silent><expr> <c-space> coc#refresh()
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"nmap <silent> gd :call <SID>goto_definition()<CR>
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"xmap <Leader>f  <Plug>(coc-format-selected)
"nmap <Leader>f  <Plug>(coc-format-selected)
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" NERDTree
map <Leader>f :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

" FZF
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

map <Leader>t :GFiles<CR>
map <c-p> :FZF<CR>
map <Leader>r :RG<CR>
map <Leader>e :Lines<CR>
map <Leader>y :Tags<CR>
map <c-o> :Buffers<CR>

" Window switching
nnoremap <Leader>w <C-W><C-W>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Window resizing
nnoremap <Leader>H :vertical resize -8<CR>
nnoremap <Leader>L :vertical resize +8<CR>
nnoremap <Leader>J :resize +4<CR>
nnoremap <Leader>K :resize -4<CR>

" Buffers
" Open new buffer
nmap <Leader>j :enew<cr>
" Move to the next buffer
nmap <Leader>l :bnext<CR>
" Move to the previous buffer
nmap <Leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
nmap <Leader>k :bp <BAR> bd #<CR>

" Jump to end of pastes
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Close tag by typing <//
iabbrev <// </<C-X><C-O>

" Escape with jk
inoremap jk <Esc>

inoremap <silent><expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"

" Replace #include with bazel build path
nnoremap <Leader>b :s/\#include "\(.*\)\/\(.*\).h"/"\/\/\1:\2",/g<CR>

" Git tools
nnoremap gz :GitGutterFold<CR>
nnoremap gh :GitGutterLineHighlightsToggle<CR>
nnoremap gD :Gdiff<CR>
nnoremap gs :Gstatus<CR>

" cpp
set cinkeys-=0#
set cinoptions+=(0,W1s
set indentkeys-=0#


" --------
" AUTOCMDS
" --------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Coc
  "autocmd CursorHold * silent call CocActionAsync('highlight')

  " Configure NERDTree
  augroup NERDTree
    au!
    autocmd StdinReadPre * let s:std_in=1 " Open NERDTree if vim started w/ no target file
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if only NERDTree is left
  augroup END

  augroup DisableMappings
    autocmd VimEnter * :iunmap <Leader>ih
    autocmd VimEnter * :iunmap <Leader>ihn
    autocmd VimEnter * :iunmap <Leader>is
  augroup END

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrc_ex
    au!

    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text setlocal textwidth=80

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END

else
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

