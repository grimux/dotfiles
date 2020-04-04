let mapleader = ","

call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'iCyMind/NeoSolarized'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nanotech/jellybeans.vim'
call plug#end()

"--- Color and theme options ---"
set termguicolors
"set bg=light

" NeoSolarized theme
"colorscheme NeoSolarized

" onedark theme
"colorscheme onedark
"let g:airline_theme='onedark'
"let g:onedark_terminal_italics=1

" palenight
colorscheme palenight
let g:airline_theme='palenight'
let g:palenight_terminal_italics=1


" Some basic things
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
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

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak \| set bg=dark<CR>
function! s:goyo_enter()
	set bg=dark
endfunction

function! s:goyo_leave()
	set bg=dark
endfunction
autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoEnter nested call <SID>goyo_leave()

map <leader>q :set bg=dark<CR>

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

" Skip multiple lines
nmap <S-j> 15j
nmap <S-k> 15k
nmap <S-l> 5w
nmap <S-h> 5b

" Splits open at the bottom and right, which is non-retarded, unlike vim 
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Run make command on Makefile
map <leader>m :w \| !make<CR>
map <leader>c :w \| !make clean<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Setting syntax of unknown files
au BufRead,BufNewFile *.ys set filetype=asm

" Copy selected text to Windows clipboard
vmap <C-c> y:new ~/.config/nvim/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.config/nvim/.vimbuffer \| clip.exe <CR><CR>

" Paste from vimbuffer into vim
"map <C-v> :r ~/.config/nvim/.vimbuffer<CR>

if exists('$TMUX')
	let &t_SI = "\ePtumx;\e\e[5 q\e\\"
	let &t_EI = "\ePtumx;\e\e[5 q\e\\"
else
	let &t_SI = "\e[5 q"
	let &t_EI = "\e[5 q"
endif
