" VIM-PLUG --------------------------------------------------------------- {{{

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" Install vim-plug if not found
if empty(glob(data_dir . '/autoload/plug.vim)'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are any missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\| PlugInstall --sync | source $MYVIMRC
			\| endif


call plug#begin()

" List your plugins here
" Tried YouCompleteMe, it fucked up my cursor so kinda gave up on it
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asyncrun.vim'
Plug 'habamax/vim-godot'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'tpope/vim-fugitive'

call plug#end()

" }}}

if v:progname =~? "evim"
  finish
endif

if !has('nvim')
	source $VIMRUNTIME/defaults.vim
endif

let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'cpp']

let mapleader = ',' 

nmap <F8> :TagbarToggle<CR>

let g:rustfmt_autosave = 1

let g:tagbar_ctags_bin = 'C:\Users\seano\Downloads\ctags-v6.1.0-x64\ctags.exe'
" VIMSCRIPT -------------------------------------------------------------- {{{
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

	

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}
" MAPPINGS --------------------------------------------------------------- {{{

" Add numbers to each line on the left-hand side.
set relativenumber

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

set undodir=$HOME/.vim/.undo//

set backupdir=$HOME/.vim/.backup//

set directory=$HOME/.vim/.swp//

" Enable auto completion menu after pressing TAB.
set wildmenu

" set wrap text atr end of the word, preventing it from being split in  two
set linebreak

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

inoremap jj <Esc>


nnoremap S :set spell! <cr> 	

" }}}

" THEMING --------------------------------------------------------------- {{{
set termguicolors
colorscheme catppuccin_mocha


let g:lightline = {
		\'colorscheme': 'catppuccin_mocha',
		\ 'active':{
		\ 	'right': [ ['lineinfo' ],
		\ 		   ['fileformat', 'fileencoding', 'filetype'] ],
		\       'left':[ [ 'mode', 'paste' ],
		\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]	
		\ },
		\ 'component_function': {
		\   'gitbranch': 'GitNoSmall',
		\   'fileformat': 'LightlineFileformat',
		\   'filetype': 'LightlineFiletype',
		\ },
		\ }
set laststatus=2
set noshowmode

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! GitNoSmall()
	return winwidth(0) > 70 && exists('*FugitiveHead') ? FugitiveHead() : ''
endfunction
function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
" }}}

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are

" GODOT  --------------------------------------------------------------- {{{

func! GodotSettings() abort
	" setlocal foldmethod=expr
	setlocal shiftwidth=4
	setlocal tabstop=4
	nnoremap <buffer> <F4> :GodotRunLast<CR>
	nnoremap <buffer> <F5> :GodotRun<CR>
	nnoremap <buffer> <F6> :GodotRunCurrent<CR>
	nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
	au FileType gdscript call GodotSettings()
augroup end

" }}}

" ASYNCRUN  --------------------------------------------------------------- {{{
let g:asyncrun_open = 8
" }}}
" COCSETUP  --------------------------------------------------------------- {{{

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" " utf-8 byte sequence
set encoding=utf-8
" " Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
"
" " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" " delays and poor user experience
set updatetime=300
"
" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved
set signcolumn=yes
"
" " Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to
" enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ?  coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
	      call CocActionAsync('doHover')
	else
	      call feedkeys('K', 'in')
       endif
endfunction


" Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location
"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

 " GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" " Remap keys for applying code actions at the cursor position
" nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" " Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" " Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" " Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
 nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" }}}
