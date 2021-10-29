-- need install
-- npm i -g vscode-langservers-extracted
-- npm i -g typescript typescript-language-server

-- local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local map_set = vim.api.nvim_set_keymap
local bmap_set = vim.api.nvim_buf_set_keymap

-- Map leader to space
g.mapleader = ' '

-- Bootstrap packer when needed
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- settings
vim.o.background = "dark"
vim.cmd([[
    syntax enable
    colorscheme gruvbox
]])
opt.backspace = {"indent", "eol", "start"}
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = false
opt.cursorcolumn = false
opt.encoding = "utf-8"
opt.smarttab = true
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.foldenable = false
opt.foldmethod = "indent"
opt.formatoptions = "l"
opt.hidden = true
opt.wrap = false
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.joinspaces = false
opt.linebreak = true
opt.number = true
opt.list = false
opt.relativenumber = false
opt.scrolloff = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = {"en_gb"}
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.cc = "80"
opt.mouse = "a"
opt.ruler = true
opt.cmdheight = 2
opt.showtabline = 2
opt.virtualedit = "block"
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

-- plugins
require('packer').startup(function ()
	use "neovim/nvim-lspconfig" 	-- Mind the semi-colons
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"
	use {"lervag/vimtex", opt=true}	-- Use braces when passing options
	use "rktjmp/lush.nvim"
	use "ellisonleao/gruvbox.nvim"
    use "nathom/filetype.nvim"
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function () require'nvim-tree'.setup{} end
    }
    use "rinx/lspsaga.nvim";
    -- "f3fora/cmp-spell";
    -- "folke/tokyonight.nvim";
    -- "jose-elias-alvarez/null-ls.nvim";
    -- "kyazdani42/nvim-tree.lua";
    -- "kyazdani42/nvim-web-devicons";
    -- "lewis6991/gitsigns.nvim";
    -- "norcalli/nvim-colorizer.lua";
    -- "numToStr/Comment.nvim";
    -- "nvim-lua/plenary.nvim";
    -- "nvim-lua/popup.nvim";
    -- "nvim-lualine/lualine.nvim";
    -- "nvim-telescope/telescope-fzy-native.nvim";
    -- "nvim-telescope/telescope.nvim";
    -- "nvim-treesitter/nvim-treesitter";
    -- "octaltree/cmp-look";
    -- "onsails/lspkind-nvim";
    -- "p00f/nvim-ts-rainbow";
    -- "phaazon/hop.nvim";
    -- "rmagatti/auto-session";
    -- "savq/paq-nvim";
    -- "tpope/vim-repeat";
    -- "tpope/vim-surround";
    -- "wellle/targets.vim";
    -- "windwp/nvim-autopairs";
    -- "windwp/nvim-ts-autotag";
    -- "winston0410/cmd-parser.nvim";
    -- "winston0410/range-highlight.nvim"
end)

-- Do not source the default filetype.vim
-- vim.g.did_load_filetypes = 1

local cmp = require('cmp')
cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
    sources = {
        {name = 'buffer'}
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        {name = 'path'}
    },{
        {name = 'cmdline'}
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = {noremap=true, silent=true}

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- nvim-tree

-- following options are the default
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = true,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- Hide the root path of the current folder on top of the tree
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

bmap_set(0, 'n', '<leader>ee', ':NvimTreeOpen<CR>', {noremap = true})
bmap_set(0, 'n', '<leader>ee', ':NvimTreeOpen<CR>', {noremap = true})

-- lsp setup
local sumneko_root_path = fn.stdpath('cache')..'/lspconfig/lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach;
    capabilities = capabilities;
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = 'Lua 5.3',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                enable = true,
                globals = {'vim', 'hs', 'it', 'describe', 'before_each', 'after_each'},
                disable = {'lowercase-global'}
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                maxPreload = 5000,
                preloadFileSize = 1000,
                checkThirdParty = false
            },
        },
    },
}

nvim_lsp.bashls.setup{
    on_attach = on_attach;
}
nvim_lsp.ccls.setup {
    on_attach = on_attach;
    cmd = {'ccls'};
    init_options = {
        compilationDatabaseDirectory = "./build/";
        index = {
            threads = 0;
        };
        clang = {
            excludeArgs = {"-frounding-math"};
        };
    }
}

nvim_lsp.gopls.setup{on_attach = on_attach;}
nvim_lsp.html.setup{on_attach = on_attach;}
nvim_lsp.jsonls.setup{on_attach = on_attach;}
nvim_lsp.tsserver.setup{on_attach = on_attach;}
nvim_lsp.pyright.setup{on_attach = on_attach;}

