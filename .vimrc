" Requires pathogen plugin manager and the fowling plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
" mkdir -p ~/.vim/plugins && curl -LSso ~/.vim/plugins/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
" git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
" git clone https://github.com/raimondi/delimitmate.git ~/.vim/bundle/delimitmate
" git clone https://github.com/edkolev/erlang-motions.vim.git ~/.vim/bundle/erlang-motions
" git clone https://github.com/preservim/tagbar.git ~/.vim/bundle/tagbar
" git clone https://github.com/vim-erlang/vim-erlang-tags.git ~/.vim/bundle/vim-erlang-tags
" git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
" git clone https://github.com/mtdl9/vim-log-highlighting.git ~/.vim/bundle/vim-log-highlighting
" git clone git clone https://github.com/yggdroot/indentline.git ~/.vim/bundle/indentline

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

"if has("cscope") && filereadable("/usr/bin/cscope")
"   set csprg=/usr/bin/cscope
"   set csto=0
"   set cst
"   set nocsverb
"   " add any database in current directory
"   if filereadable("cscope.out")
"      cs add $PWD/cscope.out
"   " else add database pointed to by environment
"   elseif $CSCOPE_DB != ""
"      cs add $CSCOPE_DB
"   endif
"   set csverb
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

"if &term=="xterm"
"     set t_Co=8
"     set t_Sb=[4%dm
"     set t_Sf=[3%dm
"endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug plugin manager
"
call plug#begin()
" The default plugin directory will be as follows:
" "   - Vim (Linux/macOS): '~/.vim/plugged'
" "   - Vim (Windows): '~/vimfiles/plugged'
" "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" " You can specify a custom plugin directory by passing it as the argument
" "   - e.g. `call plug#begin('~/.vim/plugged')`
" "   - Avoid using standard Vim directory names like 'plugin'
"
" " Make sure you use single quotes

Plug 'dr-kino/cscope-maps'
Plug 'preservim/nerdtree.git'
Plug 'raimondi/delimitmate.git'
Plug 'edkolev/erlang-motions.vim.git'
Plug 'preservim/tagbar.git'
Plug 'vim-erlang/vim-erlang-tags.git'
Plug 'tpope/vim-fugitive.git'
Plug 'mtdl9/vim-log-highlighting.git'
Plug 'yggdroot/indentline.git'

" Initialize plugin system
" " - Automatically executes `filetype plugin indent on` and `syntax enable`.
" call plug#end()
" " You can revert the settings after the call like so:
" "   filetype indent off   " Disable file-type-specific indentation
" "   syntax off            " Disable syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-pathogen for installing vim plugins
"execute pathogen#infect()

" Cscope specific
source ~/.vim/plugins/cscope_maps.vim

" Tabs and indent
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

" Spelling and word completion
set spell spelllang=en_us
set complete+=kspell

" Disable speling for file types
autocmd BufRead,BufNewFile *.erl setlocal nospell

" Override Spelling Color
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad cterm=underline,bold ctermfg=red
hi SpellCap cterm=underline,bold ctermfg=red
hi SpellRare cterm=underline,bold ctermfg=red
hi SpellLocal cterm=underline,bold ctermfg=red

"" PHP documenter script bound to Control-P
"source ~/.vim/plugins/php-doc.vim
"autocmd FileType php inoremap <C-p> <ESC>:call PhpDocSingle()<CR>i
"autocmd FileType php nnoremap <C-p> :call PhpDocSingle()<CR>
"autocmd FileType php vnoremap <C-p> :call PhpDocRange()<CR>

" vim-erlang-omnicomplete Key Override
inoremap <C-b> <C-x><C-o>

" Start scrolling n lines before border
set scrolloff=10

" Set the default color highlighting
colo default

" Override Search Color Hightlight
highlight Search guifg=#90fff0 guibg=#2050d0 ctermfg=white ctermbg=darkblue cterm=underline term=underline

" Override Vim Diff Color
highlight DiffAdd cterm=none ctermfg=black ctermbg=Green gui=none guifg=black guibg=Green
highlight DiffDelete cterm=none ctermfg=black ctermbg=Red gui=none guifg=black guibg=Red
highlight DiffChange cterm=none ctermfg=black ctermbg=Yellow gui=none guifg=black guibg=Yellow
highlight DiffText cterm=none ctermfg=black ctermbg=Magenta gui=none guifg=black guibg=Magenta

" Override Vim indentLine plugin Color
"let g:indentLine_color_term = 239

" Set the file explore view using native explorer
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 2
"let g:netrw_winsize = 8
"let g:netrw_banner = 0

" Set up hot key for NERDTree file explorer
map <C-x> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=45

"Allow usage of mouse in iTerm
"set ttyfast
"set mouse=a
"set ttymouse=xterm2

" Highlight Trailing White space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"Display whitespace
"set listchars=tab:->,trail:~,extends:>,precedes:<
"set list

"Line numbers and limits
"set number                      " Show line numbers
set cc=150                       " Ver line in 80 column
set cursorline

"Allows undo after file is closed
if exists("&undodir")
    set undofile
    set undodir=/tmp
endif

"Swap files and backup are super annoying. I save often
set noswapfile
set nobackup

"HSplit and VSplit  Min and Max
let g:maximizer_default_mapping_key = '<C-w>o'

"Load CTAGS and CSCOPE from current dir
set nocscopeverbose
set tags=tags
cs add cscope.out

"set ttyfast
set lazyredraw

" Ignore make upgrade warnings in cope
set errorformat ^=%-G%.%#Please\ upgrade\ to\ GNU\%.%#
