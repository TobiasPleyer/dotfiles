''
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = "~/.config/nvim/pack"
let mapleader      = ' '
let maplocalleader = ' '

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set clipboard=unnamed
set history=1000
set number relativenumber
set colorcolumn=80,120
set background=dark " for the dark version
set hidden
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set number relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0

" Give more space for displaying messages.
set cmdheight=2
set encoding=utf-8

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

if has('nvim')
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0 = '#4e4e4e'
  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'

  set fillchars=vert:\|,fold:-
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else
  let g:terminal_ansi_colors = [
    \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
    \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
    \ '#626262', '#d75f87', '#87af87', '#ffd787',
    \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4']
endif

let g:NERDTreeHijackNetrw = 0
let g:airline#extensions#coc#enabled = 0

highlight ColorColumn ctermbg=red
colorscheme gruvbox
syntax on
filetype plugin on

"execute pathogen#infect('bundle/{}', '~/.config/nvim/bundle/{}')

command! -nargs=0 MkTags :call system('hasktags -c -o tags .')

let g:airline_theme='gruvbox'
let g:python3_host_prog = '/usr/bin/python3'
let g:git_conflict_marker_regex = "\\(^<<<<<<< \\@=\\)\\|\\(^=======$\\)\\|\\(^>>>>>>> \\@=\\)"
let python_highlight_all=1

map <leader>n :NERDTreeToggle<CR>

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

map <leader>n :NERDTreeToggle<CR>
map <leader>m :execute "/" . g:git_conflict_marker_regex<CR>
map <leader>g :Pss<CR>
map <leader>G :Pss!<CR>
map <leader>co :copen<CR>
map <leader>cc :cclose<CR>
map <leader>cn :cn<CR>zz
map <leader>cp :cp<CR>zz
nmap <leader>h :MkTags<CR>
nmap <leader>t :Ttoggle<CR>
nmap <leader>z :TagbarToggle<CR>

" Settings for the LanguageClient-neovim plugin
let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" CoC Keybindings
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cs <Plug>(coc-fix-current)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cN <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ch :call CocAction('doHover')<CR>
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cf :call CocActionAsync('format')<CR>
nmap <silent> <leader>cl :CocList diagnostics<CR>

" Telescope bindings
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
''
