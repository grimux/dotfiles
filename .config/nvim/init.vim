"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Neovim configuration
"--- Jacob Meredith
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Plugins ---"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'vifm/vifm.vim'
"Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
"Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vimwiki/vimwiki'
Plug 'turbio/bracey.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Color and theme options ---"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set bg=dark
"let g:rainbow_active = 1

" onedark theme
"colorscheme onedark
"let g:airline_theme='onedark'
"let g:onedark_terminal_italics=1

" palenight
colorscheme palenight
let g:lightline = { 'colorscheme': 'palenight' }
let g:palenight_terminal_italics=1

" Transparent background when using themes
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set autoindent
syntax on
set encoding=utf-8
set number relativenumber
set mouse=a
set pastetoggle=<F8>
set splitbelow splitright
let mapleader = ","
set wildmode=longest,list,full
set clipboard=unnamedplus			" when yanking, send to system clipboard ("*) instead of normal buffer
autocmd FileType markdown set linebreak

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>o :setlocal spell! spelllang=en_us<CR>	" Spellcheck
nnoremap <SPACE> @q					" Use spacebar for marco at 'q'
map Q gq						" Q is unset
map <F3> :call TrimWhiteSpace()<CR>			" Call trim white space function

" Magit
map <F1> :Magit<CR>

" Nerdtree
map <F2> :NERDTree<CR>

" Goyo
map <leader>g :Goyo <BAR> set linebreak<CR>

" vimwiki
map <leader>wm :VimwikiAll2HTML<CR>
map <leader>wa :VimwikiGoto personal/mental-health/autism/autism-notes<CR>

" Shortcut split navigation
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
map <leader>bb :Bracey<CR>
map <leader>bs :BraceyStop<CR>
map <leader>br :BraceyReload<CR>

" Run output script
map <leader>p :!opout <c-r>%<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing white space
function TrimWhiteSpace()
	%s/\s*$//
	''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- vimwiki settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimwiki_jake = {}
let vimwiki_jake.path = '$HOME/vimwiki'
let vimwiki_jake.path_html = '$HOME/vimwiki/_site'
let vimwiki_jake.template_path = '$HOME/vimwiki/templates'
let vimwiki_jake.template_default = 'default'
let vimwiki_jake.template_ext = '.html'
let vimwiki_jake.syntax = 'markdown'
let vimwiki_jake.ext = '.md'
let vimwiki_jake.custom_wiki2html = 'vimwiki_markdown'
let vimwiki_jake.html_filename_parameterization = 1

let vimwiki_serena = {}
let vimwiki_serena.path = '$HOME/Documents/vimwiki-serena'
let vimwiki_serena.path_html = '$HOME/Documents/vimwiki-serena/_site'
let vimwiki_serena.template_path = '$HOME/Documents/vimwiki-serena/templates'
let vimwiki_serena.template_default = 'default'
let vimwiki_serena.syntax = 'markdown'
let vimwiki_serena.ext = '.md'
let vimwiki_serena.custom_wiki2html = 'vimwiki_markdown'

let g:vimwiki_list = [vimwiki_jake, vimwiki_serena]
let g:vimwiki_global_ext = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:goyo_enter()
	hi Normal guibg=NONE ctermbg=NONE
endfunction
function! s:goyo_leave()
	hi Normal guibg=NONE ctermbg=NONE
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Vifm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>vv :Vifm<CR>
map <leader>vs :VsplitVifm<CR>
map <leader>sp :SplitVifm<CR>
map <leader>dv :DiffVifm<CR>
map <leader>tv :TabVifm<CR>
