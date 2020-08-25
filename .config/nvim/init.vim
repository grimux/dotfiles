let mapleader = ","

call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'vimwiki/vimwiki'
Plug 'turbio/bracey.vim'
Plug 'ap/vim-css-color'
call plug#end()

"--- Color and theme options ---"
set termguicolors
set bg=light

" Dracula
"colorscheme dracula
"let g:airline_theme='dracula'
"let g:dracula_terminal_italics=1

" onedark theme
"colorscheme onedark
"let g:airline_theme='onedark'
"let g:onedark_terminal_italics=1

" palenight
colorscheme palenight
let g:airline_theme='palenight'
let g:palenight_terminal_italics=1
"----------------------------------"

" Some basic things
set nocompatible
set autoindent
syntax on
set encoding=utf-8
set number relativenumber
set mouse=a
map <F1> :Magit<CR>
map <F2> :NERDTree<CR>
nnoremap <SPACE> @q

" Enable autocompletion:
set wildmode=longest,list,full

" vimwiki settings
let g:vimwiki_list = [{
	\ 'automatic_nested_syntaxes': 1,
	\ 'path_html': '$HOME/Documents/vimwiki/_site',
	\ 'path': '$HOME/Documents/vimwiki',
	\ 'template_path': '$HOME/Documents/vimwiki/templates',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'custom_wiki2html': 'vimwiki_markdown'
\}]
map <leader>wm :VimwikiAll2HTML<CR>
let g:vimwiki_global_ext = 0

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak \| set bg=dark<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Remove trailing whitespace
function TrimWhiteSpace()
	%s/\s*$//
	''
endfunction
map <F3> :call TrimWhiteSpace()<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim 
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Run make command
map <leader>m :w \| !make<CR>
map <leader>c :w \| !make clean<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Insert date and timestamp
nnoremap <F5> "=strftime("%m/%d/%Y %I:%M %p")<CR>P
inoremap <F5> <C-R>=strftime("%m/%d/%Y %I:%M %p")<CR>

" Start Bracey (html live server)
nnoremap <F4> :Bracey<CR>

" Setting syntax of unknown files
au BufRead,BufNewFile *.ys set filetype=asm

" Copy selected text to Windows clipboard
vmap <C-c> y:new ~/.config/nvim/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.config/nvim/.vimbuffer \| clip.exe <CR><CR>

" Paste from vimbuffer into vim
"map <C-v> :r ~/.config/nvim/.vimbuffer<CR>
