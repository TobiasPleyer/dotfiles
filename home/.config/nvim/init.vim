"set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = "~/.config/nvim/pack"
let mapleader = ","

set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

set colorcolumn=80,100
highlight ColorColumn ctermbg=red

execute pathogen#infect('bundle/{}', '~/.config/nvim/bundle/{}')

filetype plugin on
map <Leader>n :NERDTreeToggle<CR>

set number relativenumber

set background=dark
colorscheme solarized8

map <Leader>s :SyntasticToggleMode<CR>

let g:python3_host_prog = '/usr/local/bin/python3.6'

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

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

let g:deoplete#enable_at_startup = 1

let g:textid_db_file = '/home/tobias/.config/nvim/rplugin/python3/textids.db'
map <Leader>t :ToggleTextId<CR>
vmap <Leader>t :'<,'>ToggleTextId<CR>

highlight Normal ctermfg=white ctermbg=darkblue
