"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Neovim configuration
"--- Jacob Meredith
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Plugins ---"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'jreybert/vimagit'
Plug 'francoiscabrol/ranger.vim'
Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'
"Plug 'tpope/vim-fugitive'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vimwiki/vimwiki'
"Plug 'turbio/bracey.vim'
Plug 'junegunn/goyo.vim'
Plug 'chrisbra/Colorizer'
" Addes new commands to read and write on root files
Plug 'lambdalisue/suda.vim'
Plug 'chrisbra/unicode.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Color and theme options ---"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set background=dark
"let g:rainbow_active = 1

"####################
"## Airline Plugin ##
"####################
"let g:airline_theme='dracula'
"let g:airline_theme='onedark'
let g:airline_theme='palenight'
let g:airline_powerline_fonts=1

"######################
"## Lightline Plugin ##
"######################
"let g:lightline = { 'colorscheme': 'palenight' }
"let g:lightline = {
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
"      \ },
"      \ 'colorscheme': 'palenight'
"      \ }

" Dracula theme
"colorscheme dracula
"let g:dracula_terminal_italics=1

" Onedark theme
"colorscheme onedark
"let g:onedark_terminal_italics=1

" Palenight theme
colorscheme palenight
let g:palenight_terminal_italics=1

" Transparent background when using themes
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE


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
autocmd FileType markdown set linebreak
set autochdir

" when yanking, send to system clipboard ("*) instead of normal buffer
set clipboard=unnamedplus

" Treat _ as a word break
set iskeyword-=_


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Controls
" zo - opens fold
" zc - closes fold
" zm - increases auto fold depth
" zr - reduces auto fold depth
"set foldmethod=indent
"set foldlevel=1
"set foldclose=all

"####################
"### Plugin Setup ###
"####################
" Ranger Plugin
let g:ranger_map_keys = 0
map <leader>f :Ranger<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spellcheck
map <leader>o :call SpellCheck()<CR>

" Easily disable highlighting
map <leader>nh :nohlsearch<CR>

" Use spacebar for marco at 'q'
nnoremap <SPACE> @q

" Unset Q and :q.  These toggle a vim command history window.
nnoremap Q :<nop>
nnoremap q: <nop>

" Delete selected text to black hole register and paste from the default
" register
vnoremap <leader>p "_dP

" Call trim white space function
map <F3> :call TrimWhiteSpace()<CR>

" Magit
map <leader>mg :Magit<CR>

" Reload vim config file
nnoremap <leader>r :source $HOME/.config/nvim/init.vim<CR>

" Goyo
map <leader>g :Goyo <BAR> set linebreak<CR>

map <leader>l :call ShowWhiteSpace()<CR>
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

" Make current file executable.
map <leader>x :!chmod +x %<CR><CR>

" Set spaces for tabs
map <leader>t :call TabsToSpaces()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing white space
function TrimWhiteSpace()
	%s/\s*$//
	''
endfunction

" Show all whitespace
function ShowWhiteSpace()
	set list! list?
	set lcs+=space:.
endfunction

" Spell check
function SpellCheck()
	setlocal spell! spell?
endfunction

" Set tabs to spaces
function TabsToSpaces()
	setlocal tabstop=4
	setlocal expandtab
	setlocal shiftwidth=4
endfunction

"--- Autofunctions
" Automatically reload nvim's config file when it is saved.
autocmd! bufwritepost init.vim source $HOME/.config/nvim/init.vim
" When my gift list is updateded, run the shell update script.
autocmd! bufwritepost gift-list.md :silent !update_giftlist


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
let g:vimwiki_list = [vimwiki_jake]
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

