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
set bg=dark

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
" Transparent background when using themes
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
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
map Q gq

" Enable autocompletion:
set wildmode=longest,list,full

" vimwiki settings
let vimwiki_jake = {}
let vimwiki_jake.path = '$HOME/Documents/vimwiki'
let vimwiki_jake.path_html = '$HOME/Documents/vimwiki/_site'
let vimwiki_jake.template_path = '$HOME/Documents/vimwiki/templates'
let vimwiki_jake.template_default = 'default'
let vimwiki_jake.template_ext = '.html'
let vimwiki_jake.syntax = 'markdown'
let vimwiki_jake.ext = '.md'
let vimwiki_jake.custom_wiki2html = 'vimwiki_markdown'

let vimwiki_serena = {}
let vimwiki_serena.path = '$HOME/Documents/vimwiki-serena'
let vimwiki_serena.path_html = '$HOME/Documents/vimwiki-serena/_site'
let vimwiki_serena.template_path = '$HOME/Documents/vimwiki-serena/templates'
let vimwiki_serena.template_default = 'default'
let vimwiki_serena.syntax = 'markdown'
let vimwiki_serena.ext = '.md'
let vimwiki_serena.custom_wiki2html = 'vimwiki_markdown'

let g:vimwiki_list = [vimwiki_jake, vimwiki_serena]
map <leader>wm :VimwikiAll2HTML<CR>
let g:vimwiki_global_ext = 0

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo <BAR> set linebreak<CR>
function! s:goyo_enter()
	hi Normal guibg=NONE ctermbg=NONE
endfunction
function! s:goyo_leave()
	hi Normal guibg=NONE ctermbg=NONE
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
nnoremap <F5> "=strftime("%A, %B %d, %Y")<CR>P
inoremap <F5> <C-R>=strftime("%A, %B %d, %Y")<CR>
map <leader>d "=strftime("%A, %B %d, %Y")<CR>P
nnoremap <F6> "=strftime("%I:%M %p")<CR>P
inoremap <F6> <C-R>=strftime("%I:%M %p")<CR>
map <leader>t "=strftime("%I:%M %p")<CR>P

" Start Bracey (html live server)
nnoremap <F4> :Bracey<CR>

" Setting syntax of unknown files
au BufRead,BufNewFile *.ys set filetype=asm

" Copy selected text to Windows clipboard
vmap <C-c> y:new ~/.config/nvim/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.config/nvim/.vimbuffer \| clip.exe <CR><CR>

" Paste from vimbuffer into vim
"map <C-v> :r ~/.config/nvim/.vimbuffer<CR>
