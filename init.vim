set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Load pathogen from the cloned source
" and run it
runtime plugins/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('plugins/bundle/{}')

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2

set history=1000 " How many commands to remember
set tabpagemax=50 " Max number of tab pages to open (50 is default)
set autoread " Automatically read a file that has changed if not edited in buffer

" backup
set backupdir=~/.local/share/nvim/swap " Keep backup files in this location
set directory=~/.local/share/nvim/swap " Keep swap files in this location

"
" au(tocmd)
"
if has('autocmd')
  filetype plugin indent on

  " When a new file is opened (BufNewFile) or when an existing file is opened (BufRead)
  " that matches the pattern Enable syntax highlighting
  " au BufNewFile,BufRead *.jsm set filetype=javascript
  " au BufNewFile,BufRead *.ts set filetype=javascript
  " au BufNewFile,BufRead *.jpp set filetype=java
  " When entering a terminal buffer, enter insert mode
  " au BufEnter * if &buftype == 'terminal' | :startinsert | endif
endif

"
" movement
"
set scrolloff=7                 " start scrolling when the cursor is this far from the top/bottom
set sidescrolloff=5             " start scrolling when the cursor is this far from the side

"
" show
"
set ruler                       " show the current row and column
set number relativenumber       " show line numbers, relative
set nowrap
set cursorline
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
colorscheme onedark

"
" search
"
set incsearch
set ignorecase
set smartcase                   " no ignorecase if Uppercase char present
set hlsearch

"
" Key mappings
"
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

inoremap jj <Esc>

" Suggested in the help
" Remap Alt+{h,j,k,l} to navigate between windows no matter if they are
" displaying a normal buffer or a terminal buffer in terminal mode
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
if has('nvim') || exists("g:gui_oni")
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

" Map NERDTree
map <C-N> :NERDTreeToggle<cr>

" tab
set expandtab  " expand tabs to spaces
set smarttab   " tab in front of a line inserts blanks according to shiftwidth
set shiftround " Round indent to multiple of shiftwidth

" indent
set autoindent                  " Copy indent from current line when starting a new line
set smartindent
set shiftwidth=2
set tabstop=2

" encoding
set ffs=unix,dos,mac

" spell check
" set spell
" set spelllang=en_us

if !exists("g:gui_oni")
  set completeopt=longest,menu
  set wildmenu                           " show a navigable menu for tab completion"
  set wildmode=full
  set wildignore=*.o,*~,*.pyc,*.class
endif

set backspace=indent,eol,start  " make backspace key work the way it should
" Allow the following keys to wrap the cursor
" b = backspace
" s = space
" < = left arrow (normal mode)
" > = right arrow (normal mode)
" [ = left arrow (insert mode)
" ] = right arrow (insert mode)
" l = l
" h = h
set whichwrap=b,s,<,>,[,],l,h

if has('syntax')
  syntax enable
endif

set formatoptions+=j " Delete comment character when joining commented lines

" Not sure what this does
runtime! macros/matchit.vim

set complete-=i      " Don't include included files in autocomplete options
set nrformats-=octal " Remove octal from the bases that will be considered in CTRL-A and CTRL-X. e.g. 007 becomes 008 instead of 010
set ttimeout         " When a key code sequence is received by the terminal UI, wait ttimeoutlen ms for it to complete
set ttimeoutlen=100  " When a key code sequence is received by the terminal UI, wait ttimeoutlen ms for it to complete

" I don't know what this does
set display+=lastline

" I don't know what this does
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if !empty(&viminfo)
  set viminfo^=!     " Don't save/restore global variables whose names start with uppercase letters
endif

" ---------
"  Extensions
" ---------
" --
" vim-javascript
" --
let g:javascript_plugin_jsdoc = 1 " Enable JSDoc highlighting
let g:javascript_plugin_flow = 1 " Enable Flow highlighting
"
" --
" vim-jsx
" --
let g:jsx_ext_required = 0 " Allow jsx syntax highlighting/indenting in js files

" --
" ale
" --
" Limit linters used for JavaScript.
" let g:ale_linters = { 'javascript': ['flow'] }
let g:ale_fixers = { 'javascript': ['prettier'] }

" let g:ale_echo_msg_error_str = '⨉'
" let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_sign_error = 'X' " could use emoji
let g:ale_sign_warning = '⚠' " could use emoji

" let g:ale_open_list = 1 " open the location list whenever it has stuff in it
let g:ale_fix_on_save = 0
let g:ale_sign_column_always = 1

" highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
" highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

" let g:ale_javascript_prettier_options = '--print-width 80 --single-quote --trailing-comma es5 --write'

" let g:ale_javascript_standard_use_global = 1
" let g:ale_javascript_standard_options = '--parser babel-eslint'
" let g:ale_javascript_standard_executable = 'semistandard'
" let g:ale_javascript_standard_use_global = 1

" let g:ale_javascript_eslint_options = ''
" let g:ale_javascript_eslint_use_global = 1

" --
" ctrl p
" --
let g:ctrlp_custom_ignore = { 'dir':  'node_modules' }

" ---------
"  Session
" ---------
"
" pathogen recommends doing this
set sessionoptions-=options " Don't let mksession store 'all options and mappings'

" ---------
"  Terminal
" ---------
"
let g:terminal_scrollback_buffer_size = 100000

" vim:set ft=vim et sw=2:
