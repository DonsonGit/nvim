-- need install
-- npm i -g vscode-langservers-extracted
-- npm i -g typescript typescript-language-server

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables

-- Map leader to space
g.mapleader = "<space>"

-- Bootstrap Paq when needed
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
	-- "savq/pad-nvim"; 		-- Let Pad manage itself
	"neovim/nvim-lspconfig"; 	-- Mind the semi-colons
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-vsnip";
    "hrsh7th/vim-vsnip";
	{"lervag/vimtex", opt=true};	-- Use braces when passing options
	"rktjmp/lush.nvim";
	"ellisonleao/gruvbox.nvim";
    -- "f3fora/cmp-spell";
    -- "folke/tokyonight.nvim";
    -- "jose-elias-alvarez/null-ls.nvim";
    -- "kyazdani42/nvim-tree.lua";
    -- "kyazdani42/nvim-web-devicons";
    -- "lewis6991/gitsigns.nvim";
    "nathom/filetype.nvim";
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
    -- "tami5/lspsaga.nvim";
    -- "tpope/vim-repeat";
    -- "tpope/vim-surround";
    -- "wellle/targets.vim";
    -- "windwp/nvim-autopairs";
    -- "windwp/nvim-ts-autotag";
    -- "winston0410/cmd-parser.nvim";
    -- "winston0410/range-highlight.nvim"
}

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

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

local sumneko_root_path = fn.stdpath('cache')..'/lspconfig/lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
nvim_lsp.sumneko_lua.setup {
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

nvim_lsp.bashls.setup{}
nvim_lsp.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        clang = {
            excludeArgs = {"-frounding-math"};
        };
    }
}

nvim_lsp.gopls.setup{}
nvim_lsp.html.setup{}
nvim_lsp.jsonls.setup{}
nvim_lsp.tsserver.setup{}

local opt = vim.opt -- to set options
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
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
