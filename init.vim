
" +================ Auto load for first time uses =================+ "

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" +================ System =================+ "

filetype plugin on
" set secure
set number
set cursorline
set hidden
" set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set autoindent
set scrolloff=4
set ttimeoutlen=0
set notimeout
" set viewoptions=cursor,folds,slash,unix
set wrap
set textwidth=0
" set indentexpr=
" set foldmethod=indent
" set foldlevel=99
" set foldenable
" set formatoptions-=tc
" set noshowmode
" set showcmd
" set wildmenu
" set ignorecase
" set smartcase
" set shortmess+=c
" set inccommand=split
" set completeopt=longest,noinsert,menuone,noselect,preview
" set ttyfast > this attr has been removed
set colorcolumn=100
set updatetime=300
set virtualedit=block
set background=dark
set synmaxcol=128
set cmdheight=2
set signcolumn=yes
" set lazyredraw
set nolazyredraw
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup
set directory=~/.config/nvim/tmp/backup
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo
endif

let mapleader="\<space>"

" +================ Plugin =================+ "

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

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'instant-markdown/vim-instant-markdown', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

call plug#end()

" +================ palenight.nvim =================+ "

colorscheme palenight
let g:lightline = { 'colorscheme': 'palenight' }
set t_Co=256
syntax sync minlines=226

" +================ vim-go.nvim =================+ "

let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_addtags_transform = "camelcase"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

" +================ coc.nvim =================+ "

" set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-python',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-highlight',
	\ 'coc-yaml']

" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
highlight CocHighlightText ctermfg=Yellow ctermbg=Gray

nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-references)

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nnoremap <silent><nowait> <leader>a :<C-u>CocList diagnostics<cr>

" +================ fzf.nvim =================+ "

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
let g:fzf_layout = { 'down': '~40%' }
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <leader>' :Buffers<CR>
nnoremap <silent> <leader>n :bn<CR>
nnoremap <silent> <leader>c :bd<CR>

" +================ fzf.nvim =================+ "

let g:lightline = {
          \ 'colorscheme': 'default',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'component_function': {
          \   'cocstatus': 'coc#status'
          \ },
          \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" +================ vim-rainbow.nvim =================+ "

let g:rainbow_active = 1

" let g:rainbow_load_separately = [
"     \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"     \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"     \ ]
" 
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" +================ coc-explorer =================+ "

nmap <silent> <leader>e :CocCommand explorer<CR>

" +================ vim-devicons.nvim =================+ "

set encoding=UTF-8

" +================ nerdcommenter.nvim =================+ "

let g:NERDSpaceDelims = 1

" +================ vista.nvim =================+ "

let g:vista_default_executive = 'coc'
nmap <silent> <leader>t :Vista!!<CR>
nmap <silent> <leader>r :Vista focus<CR>


" +================ vim-instant-markdown.nvim =================+ "
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
" let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 1


" +================ vim-table-mode.nvim =================+ "
noremap <leader>tm :TableModeToggle<CR>
" let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" +================ bullets.nvim =================+ "
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]

" +================ vim-markdown-toc.nvim =================+ "
" let g:vmt_auto_update_on_save = 0
" let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'
