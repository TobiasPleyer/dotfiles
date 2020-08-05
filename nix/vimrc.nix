''
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = "~/.config/nvim/pack"
let mapleader = ","

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

set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set clipboard=unnamed
set history=1000
set wrap!
set number relativenumber
set colorcolumn=80,120
set background=dark " for the dark version
set hidden

highlight ColorColumn ctermbg=red

"execute pathogen#infect('bundle/{}', '~/.config/nvim/bundle/{}')

command! -nargs=0 MkTags :call system('hasktags -c -o tags .')

filetype plugin on
map <Leader>n :NERDTreeToggle<CR>

let g:airline_theme='one'
colorscheme one
" colorscheme solarized8
" set background=light " for the light version


let g:python3_host_prog = '/usr/bin/python3'

map <Leader>s :SyntasticToggleMode<CR>

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_haskell_checkers = ["hlint"]

"let g:hindent_on_save = 1
"let g:hindent_indent_size = 4
"let g:hindent_line_length = 120

let g:git_conflict_marker_regex = "\\(^<<<<<<< \\@=\\)\\|\\(^=======$\\)\\|\\(^>>>>>>> \\@=\\)"

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

let python_highlight_all=1
syntax on

function! GetFuncs()
    let g:funcList = []
    %g/\v^\w+ (\w+::)?\w+\([^)]*\)$/call add(g:funcList, "./Src/OpcPlcErrorSource.cpp#" . line(".") . "#" . getline("."))
    call setqflist([], ' ', {'title': 'Functions in ' . expand("%:t"), 'id' : 'myQF', 'lines' : g:funcList, 'efm':'%f#%l#%m'})
endfunction

nnoremap <silent> <Leader>f :call GetFuncs()<CR>

let g:pss_permanent_args = '--exclude-pattern="moc_.*" --exclude-pattern="tags" --ignore-dir="dist" --ignore-dir="dist-newstyle"'

" Settings for the LanguageClient-neovim plugin
"let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
"map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
"map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
"map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
"map <Leader>lb :call LanguageClient#textDocument_references()<CR>
"map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
"map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

"let g:deoplete#enable_at_startup = 1
"
"let g:textid_db_file = '/home/tobias/.config/nvim/rplugin/python3/textids.db'
nmap <Leader>t :MkTags<CR>

map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :execute "/" . g:git_conflict_marker_regex<CR>
map <Leader>g :Pss<CR>
map <Leader>G :Pss!<CR>
map <Leader>co :copen<CR>
map <Leader>cc :cclose<CR>
map <Leader>b :cn<CR>zz
map <Leader>v :cp<CR>zz
nmap <Leader>z :TagbarToggle<CR>

" CoC Keybindings
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cs <Plug>(coc-fix-current)
nmap <silent> <leader>cS <Plug>(coc-codeaction)
nmap <silent> <leader>ca <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cA <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cg :call CocAction('doHover')<CR>
nmap <silent> <leader>cu <Plug>(coc-references)
nmap <silent> <leader>cp :call CocActionAsync('format')<CR>

let g:tagbar_type_elm = {
      \ 'kinds' : [
      \ 'f:function:0:0',
      \ 'm:modules:0:0',
      \ 'i:imports:1:0',
      \ 't:types:1:0',
      \ 'a:type aliases:0:0',
      \ 'c:type constructors:0:0',
      \ 'p:ports:0:0',
      \ 's:functions:0:0',
      \ ]
      \}
''
