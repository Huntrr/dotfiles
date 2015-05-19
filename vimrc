" Hunter Lightman's vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" -------
" PLUGINS
" -------
  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " Vundle plugin calls
  Plugin 'xolox/vim-misc'
  Plugin 'marijnh/tern_for_vim'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'digitaltoad/vim-jade'
  Plugin 'wavded/vim-stylus'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'bling/vim-airline'
  Plugin 'wincent/command-t'
  Plugin 'vim-scripts/argtextobj.vim' " Adds the ia and aa text objects (for arguments)
  Plugin 'michaeljsmith/vim-indent-object' " Adds the ii and ai text objects (for indent levels)
  Plugin 'sjl/gundo.vim' " Graphical undo
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'xolox/vim-session'
  Plugin 'moll/vim-node'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  Plugin 'garbas/vim-snipmate'
  Plugin 'honza/vim-snippets'
  Plugin 'tpope/vim-surround' " Adds s selector (i.e. cs'[ will change surrounding ' to [)
  Plugin 'scrooloose/nerdcommenter' " Adds <LEADER>c ... commands to change comment state
 
  " All of your Plugins must be added before the following line
  call vundle#end()            " required

  filetype plugin indent on    " required


let mapleader=" "

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


" ------------
" Basic config
" ------------
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
  set showbreak=▸
  set laststatus=2 " show statusline always
  set cursorline
  hi CursorLine guibg=#6d6d6d
  set showmatch " show matching paren
  set wildmenu

  " airline
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

" ----------
" Appearance
" ----------
  if (!has("gui_running"))
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    hi Visual term=reverse cterm=reverse ctermfg=10 ctermbg=7
  endif

  " Switch syntax highlighting on, when the terminal has colors
  " Also switch on highlighting the last used search pattern.
  if &t_Co > 2 || has("gui_running")
    syntax enable
    set hlsearch
    set background=dark
    colorscheme solarized
  endif

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

  " Disable arrow keys
  noremap <Up> <Nop>
  noremap <Down> <Nop>
  noremap <Left> <Nop>
  noremap <Right> <Nop>

  " Switch off search highlight until next search (clear the highlight)
  nnoremap <silent> <Leader>/ :nohlsearch<CR>

  " NERDTree
  map <Leader>f :NERDTreeToggle<CR>

  " Window switching
  nnoremap <Leader>w <C-W><C-W>
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-h> <c-w>h
  nnoremap <c-l> <c-w>l

  " Gundo
  nnoremap <Leader>u :GundoToggle<CR>

  " save session
  nnoremap <leader>s :SaveSession<CR>
  nnoremap <leader>o :OpenSession<CR>

  " Buffers
  " Open new buffer
  nmap <leader>T :enew<cr>
  " Move to the next buffer
  nmap <leader>l :bnext<CR>
  " Move to the previous buffer
  nmap <leader>h :bprevious<CR>
  " Close the current buffer and move to the previous one
  nmap <leader>q :bp <BAR> bd #<CR>

  " System buffer paste
  vmap <Leader>y "+y
  vmap <Leader>d "+d
  nmap <Leader>p "+p
  nmap <Leader>P "+P
  vmap <Leader>p "+p
  vmap <Leader>P "+P

  " Jump to end of pastes
  vnoremap <silent> y y`]
  vnoremap <silent> p p`]
  nnoremap <silent> p p`]

  " Visual line mode w/ SPACE SPACE
  nnoremap <Leader><Leader> V

  " Snip mate
  imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
  smap <C-J> <Plug>snipMateNextOrTrigger

" --------
" AUTOCMDS
" --------
  " Only do this part when compiled with support for autocommands.
  if has("autocmd")

    " Configure stylus styling
    autocmd BufNewFile,BufReadPost *.styl set filetype=stylus

    " Configure NERDTree
    autocmd StdinReadPre * let s:std_in=1 " Open NERDTree if vim started w/ no target file
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if only NERDTree is left

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrc_ex
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

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

    set autoindent		" always set autoindenting on

  endif " has("autocmd")

  " Convenient command to see the difference between the current buffer and the
  " file it was loaded from, thus the changes you made.
  " Only define it when not defined already.
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
  endif

" Auto-reloads vimrc
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
