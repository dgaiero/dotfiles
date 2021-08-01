set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

Plugin 'chriskempson/base16-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'vim-ruby/vim-ruby'
Plugin 'maciakl/vim-neatstatus'
Plugin 'elzr/vim-json'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'Yggdroot/indentLine'
Plugin 'nvie/vim-flake8'
Plugin 'chrisbra/csv.vim'
Plugin 'junegunn/vim-emoji'
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'ternjs/tern_for_vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""BASE CONFIG""""""""""""""""""""
" color theme setup
set number
syntax enable
highlight LineNr term=bold cterm=NONE ctermfg=LightGray ctermbg=DarkGray gui=NONE guifg=LightGray guibg=DarkGray
" set background=dark
" let base16colorspace=256  " Access colors present in 256 colorspace
" :silent! colorscheme base16-ocean
" :silent! colorscheme base16-3024
" :silent! colorscheme base16-default-dark

" backspace available
set backspace=2

" backspace once to delete
set smarttab

" indentation
set autoindent
set smartindent

" allows the use of a mouse
set mouse=a

" automatically delete trailing spaces or Tab when saves file
autocmd BufWritePre * :%s/\s\+$//e

" filling TAB
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

" code folding indentation beneath the cursor is in the folded or unfolded
" with za command
set fdm=indent
" default expansion
set foldlevel=99


" when you open a file always jumps to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif


"""""""""""""""""""""""""KEY MAPPING""""""""""""""""""""
" NORMAL mode Ctrl + a select all and copy it to the clipboard
nmap <C-c> gg"+yG

" VISUAL mode Ctrl + c to copy selected text to the clipboard
vmap <C-c> "+y

" Ctrl + v to paste equal
inoremap <C-v> <ESC>"+pa

" write to read-only files w!!
cmap w!! w !sudo tee >/dev/null %

" <F2> Switch line numbers
nnoremap <F2> :set nonu!<CR>:set foldcolumn=0<CR>

" <F3> Open the directory tree
nmap <silent> <F3> :NERDTreeToggle<CR>

" <F4> display TagList
nmap <silent> <F4> :TagbarToggle<CR>

" <F5> to run the script
if exists("$VIRTUAL_ENV")
	autocmd FileType python map <buffer> <F5> :!$VIRTUAL_ENV'/bin/python' %<CR>
else
	autocmd FileType python map <buffer> <F5> :!python %<CR>
endif

autocmd FileType javascript map <buffer> <F5> :!node %<CR>

" <F6> new tab
map <F6> <Esc>:tabnew<CR>

" <F7> Copy and paste with indent
set pastetoggle=<F7>

" <F8> sort import and auto pep8
autocmd FileType python map <buffer> <F8> :!yapf -i % --style=google;isort %;<CR><CR>

" add word to current quote
nnoremap w" viw<esc>a"<esc>hbi"<esc>lel
nnoremap w' viw<esc>a'<esc>hbi'<esc>lel

" in the Normal Mode and Visual / Select Mode, use the Tab key and the
" Shift-Tab key to indent text
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" quicker window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" emoji
imap <C-e> <C-X><C-U>


"""""""""""""""""""""""""PLUGIN CONFIG""""""""""""""""""""
" Syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Emoji
set completefunc=emoji#complete

" NERD Commenter
" NERD Commenter -- Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" NERD Commenter -- Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" NERD Commenter -- Align line-wise comment delimiters flush left instead
" of following code indentation
let g:NERDDefaultAlign = 'left'

" Nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

" CtrlP
let g:ctrlp_show_hidden = 1

" Jedi-vim setup
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_command = "<C-Space>"

" Flake8
let g:flake8_show_in_file = 1
let g:flake8_show_in_gutter = 1
autocmd! BufRead,BufWritePost *.py call Flake8()

" Omni completion
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
