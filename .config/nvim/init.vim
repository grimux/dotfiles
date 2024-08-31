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
Plug 'bling/vim-bufferline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'freitass/todo.txt-vim'
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
let maplocalleader = "t"
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

"map <leader>s :call ReSpell()<CR>
map <F2> :setlocal spell \| call feedkeys("]s") \| :call feedkeys("z=")<CR>

nmap <leader>w :write
nmap <leader>sw :SudaWrite

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

" Reload vim config file
nnoremap <leader>r :source $HOME/.config/nvim/init.vim<CR>

" Buffer keybind shortcuts
map <leader>bn :bnext<CR>
map <leader>bp :bprevious<CR>
map <leader>bd :bdelete<CR>

" Show whitespace as characters.
map <leader>l :call ShowWhiteSpace()<CR>

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

" Make current file executable.
map <leader>x :!chmod +x %<CR><CR>

" Set spaces for tabs
map <leader>t :call TabsToSpaces()<CR>

" Show custom keybinds
map <leader>/ :call ShowMyKeybinds()<CR>
"map <leader>/ :map <C-d>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Magit
map <leader>mg :Magit<CR>

" Goyo
map <leader>g :Goyo <BAR> set linebreak<CR>

" vimwiki
nmap <leader>wm :VimwikiAll2HTML<CR>

" Start Bracey (html live server)
map <leader>bb :Bracey<CR>
map <leader>bs :BraceyStop<CR>
map <leader>br :BraceyReload<CR>

" Vim-Bufferline
let g:bufferline_echo = 0

" Todo.txt completed file.
let g:todo_done_filename = 'todo.archive.txt'

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

" Goto misspelled word
" Need to finish writing this function as it does not work right now.
function ReSpell()
	setlocal spell
	call feedkeys("gg")
	call feedkeys("0")
	let current_line = line(".")
	let last_line = line("$")

	while current_line <= last_line
		let misspelled_word = spellbadword()
		echo "Line:" current_line
		echo "Bad Word:" misspelled_word

		if misspelled_word == ['', '']
			call feedkeys("j")
			let current_line += 1
			continue
		else
			"call spellbadword()
			let current_word = expand("<cword>")
			echo "Current word:" current_word
			"call spellsuggest(current_word)
		endif

		"echo current_line
		"call feedkeys("]s")
		"call feedkeys("z=")
		"let current_line = line(".")
	endwhile
endfunction

" Set tabs to spaces
function TabsToSpaces()
	setlocal tabstop=4
	setlocal expandtab
	setlocal shiftwidth=4
endfunction

" Show keybinds in a searchable buffer
function ShowMyKeybinds()
	"filter /\,*./ map
	lua require'telescope.builtin'.keymaps{}
endfunction

function! s:ShowMaps()
	let old_reg = getreg("a")	     " save the current content of register a
	let old_reg_type = getregtype("a") " save the type of the register as well
try
	redir @a			     " redirect output to register a
	" Get the list of all key mappings silently, satisfy "Press ENTER to continue"
	silent nmap | call feedkeys("\<CR>")
	redir END			     " end output redirection
	vnew				     " new buffer in window
	put a				     " put content of register
	" Sort on 4th character column which is the key(s)
	"%!sort -k1.4,1.4
finally				     " Execute even if exception is raised
	call setreg("a", old_reg, old_reg_type) " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function

nnoremap \m :ShowMaps<CR>	     " Map keys to call the function

" Format XML files
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

nnoremap = :FormatXML<Cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Auto-Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically reload nvim's config file when it is saved.
autocmd! bufwritepost init.vim source $HOME/.config/nvim/init.vim
" When my gift list is updateded, run the shell update script.
autocmd! bufwritepost gift-list.md :silent !update_giftlist


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--- Menus
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run emenu command to show all avalible menus.
nmap <F4> :emenu <C-Z>

"--- Date Menu ---"
"
" Uses the strftime function to get the current date or time.
" `"` - the register to place the return value in.
" `<CR>` - to simulate pressing enter.
" `P` - to simulate pressing `P` for paste.
"
" Full date format
" ie: Monday, May 01, 2004
amenu Date.Full "=strftime('%A, %B %d, %Y')<CR>P

" Short date format
" ie: 05/01/2004
amenu Date.Short "=strftime('%m/%d/%Y')<CR>P

" Current time
" ie: 06:45 PM
amenu Date.Time "=strftime('%I:%M %p')<CR>P

" Open the Date menu.
" Normal mode and insert mode are supported.
nnoremap <leader>d :emenu Date.
nnoremap <F5> :emenu Date.
inoremap <F5> <C-O>:emenu Date.






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
let vimwiki_jake.diary_header = "Jake's Diary"
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

