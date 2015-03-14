set nocp
" source ~/dotfiles/vim/.vim.ruby/autoload/pathogen.vim
" execute pathogen#infect('~/dotfiles/vim/.vim.ruby/bundle/{}')

filetype off
" set runtimepath+=~/dotfiles/vim/.vim.ruby/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#rc()
call vundle#rc(expand('~/dotfiles/vim/.vim.ruby/bundle'))

Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tomtom/tcomment_vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'jgdavey/tslime.vim'
Bundle 'jpo/vim-railscasts-theme'

colorscheme railscasts

set shell=/bin/bash
set tags=./tags
set backspace=indent,eol,start
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set number
set laststatus=2
set ruler
set ttyfast
set mouse=a
set ttymouse=xterm2

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=5

let g:rails_statusline = 1

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

let g:rspec_command = 'call Send_to_Tmux("spring rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" Syntastic
syntax on
filetype on
filetype indent on
filetype plugin on
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" hi StatusLine ctermbg=White ctermfg=0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" RVM
set statusline=
set statusline+=%<                       " cut at start
set statusline+=%2*\ [%n%H%M%R%W]\ %*       " buffer number, and flags
set statusline+=\ 
set statusline+=%-40f                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*\ %y\ %*%*               " file type
set statusline+=\ 
set statusline+=%10\((%l/%L)%)            " line and column
set statusline+=\ 
set statusline+=%P                        " percentage of file
set statusline+=\ 
set statusline+=%1*\ %{rvm#statusline()}\ 
