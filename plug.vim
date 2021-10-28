
call plug#begin('~/.vim/plugged')

Plug 'drewtempelmeyer/palenight.vim'
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
" Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
" 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" 
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
" Plug 'Lokaltog/vim-easymotion'
Plug 'liuchengxu/vista.vim'
Plug 'SirVer/ultisnips'

" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'instant-markdown/vim-instant-markdown', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

call plug#end()

