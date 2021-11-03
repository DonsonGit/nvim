-- need install
-- npm i -g vscode-langservers-extracted
-- npm i -g typescript typescript-language-server

-- local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
-- local map_set = vim.api.nvim_set_keymap
local bmap_set = vim.api.nvim_buf_set_keymap

-- Map leader to space
g.mapleader = ' '

-- Bootstrap packer when needed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
require('packer').startup(function (use)
	use "neovim/nvim-lspconfig" 	-- Mind the semi-colons
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/vim-vsnip"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim";
	use "rktjmp/lush.nvim"
	use "ellisonleao/gruvbox.nvim"
    use "nathom/filetype.nvim"
    use "rinx/lspsaga.nvim";
    use "numToStr/Comment.nvim";
    use "windwp/nvim-autopairs";
    use {"nvim-telescope/telescope.nvim", config = function () require'telescope'.setup{} end};
    use {"norcalli/nvim-colorizer.lua", config = function () require'colorizer'.setup{} end};
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = function () require'nvim-tree'.setup{} end};
    use {'nvim-lualine/lualine.nvim', config = function () require'lualine'.setup{options = {theme = 'gruvbox'}} end};
    use {"lewis6991/gitsigns.nvim", config = function () require'gitsigns'.setup{} end};
    use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'};
    use {"phaazon/hop.nvim", branch = 'v1', config = function () require'hop'.setup{} end };
    use "p00f/nvim-ts-rainbow";
    use "onsails/lspkind-nvim";
    -- "windwp/nvim-ts-autotag";
    -- "f3fora/cmp-spell";
    -- "jose-elias-alvarez/null-ls.nvim";
    -- "rmagatti/auto-session";
end)

-- hop

bmap_set(0, 'n', '<leader>jj', ':HopWord<CR>', {noremap = true})
bmap_set(0, 'n', '<leader>j1', ':HopChar1<CR>', {noremap = true})
bmap_set(0, 'n', '<leader>j2', ':HopChar2<CR>', {noremap = true})
bmap_set(0, 'n', '<leader>jl', ':HopLine<CR>', {noremap = true})

-- nvim-telescope

bmap_set(0, 'n', '<leader><C-p>', ':Telescope find_files<CR>', {noremap = true})
bmap_set(0, 'n', '<leader><C-f>', ':Telescope live_grep<CR>', {noremap = true})

-- nvim-treesitter

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}

-- Do not source the default filetype.vim
-- vim.g.did_load_filetypes = 1

-- lspkind-nvim
local lspkind = require'lspkind'
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
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
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

-- nvim-autopairs

require'nvim-autopairs'.setup{}
if vim.bo.filetype ~= 'lua' then
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
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
bmap_set(0, 'n', '<leader>ew', ':NvimTreeClose<CR>', {noremap = true})

-- numToStr/Comment.nvim

require("Comment").setup({
    ---Add a space b/w comment and the line
    ---@type boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = false,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|function
    ignore = nil,

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---@type table
    mappings = {
        ---operator-pending mapping
        ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
        basic = true,
        ---extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
    },

    ---LHS of toggle mapping in NORMAL + VISUAL mode
    ---@type table
    toggler = {
        ---line-comment keymap
        line = '<C-_>',
        ---block-comment keymap
        block = 'gbc',
    },

    ---LHS of operator-pending mapping in NORMAL + VISUAL mode
    ---@type table
    opleader = {
        ---line-comment keymap
        line = '<leader><C-_>',
        ---block-comment keymap
        block = 'gb',
    },

    ---Pre-hook, called before commenting the line
    ---@type function|nil
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type function|nil
    post_hook = nil,
})

-- lsp setup
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
    -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

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

