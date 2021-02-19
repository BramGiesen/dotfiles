"  ___      ___ ___  _____ ______   ________  ________
" |\  \    /  /|\  \|\   _ \  _   \|\   __  \|\   ____\
" \ \  \  /  / | \  \ \  \\\__\ \  \ \  \|\  \ \  \___|
"  \ \  \/  / / \ \  \ \  \\|__| \  \ \   _  _\ \  \
" __\ \    / /   \ \  \ \  \    \ \  \ \  \\  \\ \  \____
"|\__\ \__/ /     \ \__\ \__\    \ \__\ \__\\ _\\ \_______\
"\|__|\|__|/       \|__|\|__|     \|__|\|__|\|__|\|_______|


" load plugins:

    call plug#begin('~/.vim/plugged')

        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'morhetz/gruvbox'
        Plug 'preservim/nerdtree'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'vimwiki/vimwiki'
        Plug 'mileszs/ack.vim'
        Plug 'octol/vim-cpp-enhanced-highlight'
        Plug 'adelarsq/vim-matchit'
        Plug 'airblade/vim-gitgutter'
        Plug 'yuezk/vim-js'
        Plug 'nanotech/jellybeans.vim'

    call plug#end()

" Color Scheme ================================================================

    syntax enable
    colorscheme gruvbox

    let g:gruvbox_contrast_dark = 1
    let g:gruvbox_termcolors = 1

" General Behavior ============================================================

    set visualbell

" disable compatibility mode
    set nocompatible

    set grepprg=grep\ -nH\ $*
    let g:tex_flavor = "latex"

    let OmniCpp_GlobalScopeSearch = 1

    filetype plugin on
    filetype plugin indent on

" Search word under cursus Ack plugin
    noremap <Leader>a :Ack <cword><cr>

" Don't fold markdown files
    let g:vim_markdown_folding_disabled = 1

    let  g:C_UseTool_cmake    = 'yes'
    let  g:C_UseTool_doxygen = 'yes'

" Airline theme
    let g:airline_theme='gruvbox'

" Tabs to spaces
    set expandtab

" The width of a TAB is set to 4.
    set tabstop=4

" Indents will have a width of 4
    set shiftwidth=4

" Sets the number of columns for a TAB
    set softtabstop=4

" High light search
    set hlsearch

" auto-complete in menu
    set wildmode=longest,list,full

" command line completion
    set wildmenu

" Syntax highlighting
    syntax on

" Start nerd tree toggle
    map <C-n> :NERDTreeToggle<CR>

" show everything as plane text
    set conceallevel=0

" disable arrow keys in normal mode
    noremap <Up> <Nop>
    noremap <Down> <Nop>
    noremap <Left> <Nop>
    noremap <Right> <Nop>

" Change bindings for increasing and decreasing number to prevent conflict
" with tmux
    nmap \s <C-a>
    nmap \x <C-x>

" use Control J to split a line
    nmap Z i<cr><esc>k$

" Inset one character in insert mode
    nnoremap <C-i> i_<Esc>r

" display numbers on side bar
    set number

" set relative numbers on side bar
    set number relativenumber

" set split behavior
    set splitbelow
    set splitright

" show trailing white spaces
    autocmd BufWinEnter <buffer> match Error /\s\+$/
    autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
    autocmd InsertLeave <buffer> match Error /\s\+$/
    autocmd BufWinLeave <buffer> call clearmatches()

" indentLine
let g:indentLine_char_list = ['┊']

" AUTO COMMANDS ======================================================

fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("ags","Ag! --path-to-ignore ~/.ignore")

func! WordProcessor()
  " movement changes
  map j gj
  map k gk
  setlocal textwidth=85
  setlocal spell spelllang=en_us
  set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
  set complete+=s
endfu
com! WP call WordProcessor()

func! WordProcessorDutch()
  " movement changes
  map j gj
  map k gk
  setlocal textwidth=85
  setlocal spell spelllang=nl_NL
  set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
  set complete+=s
endfu
com! WPNL call WordProcessorDutch()

set runtimepath^=~/.vim/bundle/ag

" VIMWIKI ================================================================

let g:vimwiki_list = [{'path': '~/vimwiki', 'template_path': '~/vimwiki/templates/',
         \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.md',
         \ 'path_html': '~/vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown',
         \ 'html_filename_parameterization': 1,
         \ 'template_ext': '.tpl'}]

" if hidden is not set, TextEdit might fail.
    set hidden

" Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

" Better display for messages
    set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

" don't give |ins-completion-menu| messages.
    set shortmess+=c

" always show signcolumns
    set signcolumn=yes

" COC ================================================================

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
    inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
