scriptencoding utf-8

" This is where most of my basic keymapping goes.
"
"   Plugin keymaps will all be found in `./after/plugin/*`

nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
nnoremap <Right> gt
nnoremap <Left>  gT

" For long, wrapped lines
nnoremap k gk
" For long, wrapped lines
nnoremap j gj

" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O

" Run the last command
nnoremap <leader><leader>c :<up>

" Map execute this line
function! s:executor() abort
  if &ft == 'lua'
    call execute(printf(":lua %s", getline(".")))
  elseif &ft == 'vim'
    exe getline(">")
  endif
endfunction
nnoremap <leader>x :call <SID>executor()<CR>

vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>

" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Sizing window horizontally
nnoremap <c-,> <C-W><
nnoremap <c-.> <C-W>>
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>

" Sizing window vertically
" taller
nnoremap <A-t> <C-W>+
" shorter
nnoremap <A-s> <C-W>-

" Move easily to the next error
nnoremap <leader>l :lnext<CR>
nnoremap <leader>h :lprevious<CR>

" Helpful delete/change into blackhole buffer
nmap <leader>d "_d
nmap <leader>c "_c
nmap <space>d "_d
nmap <space>c "_c

" Change the working directory for everybody
nnoremap <leader>cd :windo lcd 

if has('nvim')
    " Make esc leave terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <Esc><Esc> <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l

    " Try and make sure to not mangle space items
    tnoremap <S-Space> <Space>
    tnoremap <C-Space> <Space>
endif

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

nnoremap <leader><leader>n :normal!<space>
vnoremap <leader><leader>n :normal!<space>

command! -nargs=0 MkTags :call system('hasktags -c -o tags .')

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

map <leader>bt :ToggleBufExplorer<CR>
map <leader>n :ToggleBufExplorerNvim<CR>
map <leader>N :NERDTreeToggle<CR>
map <leader>m :execute "/" . g:git_conflict_marker_regex<CR>
map <leader>co :copen<CR>
map <leader>cc :cclose<CR>
map <leader>cn :cn<CR>zz
map <leader>cp :cp<CR>zz
nmap <leader>h :MkTags<CR>
nmap <leader>t :Ttoggle<CR>

" CoC keybindings
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
nnoremap <leader>cG :CocSearch<space>
nnoremap <leader>cg :CocSearch<space><C-R>=expand('<cword>')<CR>

" Harpoon keybindings
nnoremap <silent><leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><leader>hh :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>ht :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <silent><C-A-j> :lua require("harpoon.mark").set_current_at(1)<CR>
nnoremap <silent><C-A-k> :lua require("harpoon.mark").set_current_at(2)<CR>
nnoremap <silent><C-A-l> :lua require("harpoon.mark").set_current_at(3)<CR>
nnoremap <silent><C-A-;> :lua require("harpoon.mark").set_current_at(4)<CR>
nnoremap <silent><A-j> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><A-k> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><A-l> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><A-;> :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent><A-u> :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <silent><A-i> :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <silent><A-o> :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <silent><A-p> :lua require("harpoon.term").gotoTerminal(4)<CR>

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
