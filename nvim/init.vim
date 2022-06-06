packadd! onedark.vim

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" -------------
" coc.nvim
" -------------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

















set mouse=a

"
" Colors
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

set laststatus=2

set history=1000 " How many commands to remember
set tabpagemax=50 " Max number of tab pages to open (50 is default)
set autoread " Automatically read a file that has changed if not edited in buffer

" --------
" backup
" --------
" Since backup is disabled, comment out this line
" set backupdir=~/.local/share/nvim/swap " Keep backup files in this location
"
" I'm not sure why I modified this. Seems fine to keep the default
" set directory=~/.local/share/nvim/swap " Keep swap files in this location

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
set background=dark
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
" set expandtab  " expand tabs to spaces
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

" if !exists("g:gui_oni")
"   set completeopt=longest,menu,preview
"   set wildmenu&
"   set wildmode=list,full
"   set wildignore=*.o,*~,*.pyc,*.class
" endif

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
