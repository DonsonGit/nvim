
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader="\<space>"

set noshowmode
syntax enable
set hidden
set nowrap
set encoding=utf-8
set pumheight=10
set fileencoding=utf-8
set ruler
set cmdheight=2
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set t_Co=256
set conceallevel=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set scrolloff=4
set textwidth=0
set smarttab
set expandtab
set smartindent
set autoindent
set laststatus=0
set number
set cursorline
set background=dark
set showtabline=2
set nobackup
set nowritebackup
set colorcolumn=100
set updatetime=300
set timeoutlen=500
set formatoptions-=cro
set clipboard=unnamedplus
set virtualedit=block

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup
set directory=~/.config/nvim/tmp/backup
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo
endif


au! BufWritePost $MYVIMRC source %
