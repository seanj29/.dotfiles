set nocompatible              " be iMproved, required
filetype off                  " required

" VIM-PLUG --------------------------------------------------------------- {{{

call plug#begin()

" List your plugins here

Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py' }
Plug 'habamax/vim-godot'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'

call plug#end()
" }}}

if v:progname =~? "evim"
  finish
endif

if !has('nvim')
	source $VIMRUNTIME/defaults.vim
endif

let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'cpp']

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
set number

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

" }}}

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

if !has_key( g:, 'ycm_language_server' )
  let g:ycm_language_server = []
endif

let g:ycm_language_server += [
  \   {
  \     'name': 'godot',
  \     'filetypes': [ 'gdscript' ],
  \     'project_root_files': [ 'project.godot' ],
  \     'port': 6005
  \   }
  \ ]


