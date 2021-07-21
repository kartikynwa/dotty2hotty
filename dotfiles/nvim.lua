-- DOTDEST=.config/nvim/init.lua
--
--                     Presenting
--      __        __  __        __
--     |__| ____ |__|/  |_     |  |  __ _______
--     |  |/    \|  \   __\    |  | |  |  \__  \
--     |  |   |  \  ||  |      |  |_|  |  // __ \_
--     |__|___|  /__||__|   /\ |____/____/(______/
--             \/           \/
--
--                    A config file
--
--            Starring: neovim 0.5.0-nightly


-- reduce verbosity
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local execute = api.nvim_command


-----------------
-- packer.nvim --
-----------------
-- bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
execute 'packadd packer.nvim'

-- install plugins
require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use '9mm/vim-closer'
  use 'tpope/vim-surround'
  use 'justinmk/vim-sneak'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'mileszs/ack.vim'
  use 'ziglang/zig.vim'
  use 'psf/black'
  use 'famiu/feline.nvim'
  use 'jparise/vim-graphql'
  use 'rust-lang/rust.vim'
end)


---------
-- lsp --
---------
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = true,
})


----------------
-- completion --
----------------
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

cmd "inoremap <silent><expr> <C-Space> compe#complete()"
cmd "inoremap <silent><expr> <CR>      compe#confirm('<CR>')"
cmd "inoremap <silent><expr> <C-e>     compe#close('<C-e>')"
cmd "inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })"
cmd "inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })"
cmd "highlight link CompeDocumentation NormalFloat"

----------
-- rust --
----------
require'lspconfig'.rust_analyzer.setup{}


----------------
-- typescript --
----------------
require'lspconfig'.tsserver.setup{}


------------
-- python --
------------
require'lspconfig'.jedi_language_server.setup{}
-- require'lspconfig'.jedi_language_server.setup{}
cmd 'autocmd BufWritePre *.py Black'


------------------
-- nvim options --
------------------
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

cmd 'colorscheme gruvbox'
local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'wrap', false)                               -- Disable line wrap
opt('w', 'relativenumber', true)                      -- Relative line numbers

--netre settings
g.netrw_banner = 0     -- Hide annoying 'help' banner
g.netrw_liststyle = 3  -- Use tree view
g.netrw_winsize = '30' -- Smaller default window size


-----------------
-- keybindings --
-----------------
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "
map('n', '<esc>', ':noh<CR><esc>', {silent = true})
map('n', '<Leader>.', ':Files<CR>')
map('n', '<Leader>>', ':GFiles<CR>')
map('n', '<Leader>,', ':Buffers<CR>')
map('n', '<Leader>/', ':Rg<CR>')
map('n', '<Leader>n', ':Explore<CR>')
map('n', '<Leader>q', ':close<CR>')


----------------
-- Statusline --
----------------
require'feline'.setup(
  {
    preset = 'noicon',
    colors = {
      fg = "#ebdbb2",
      bg = "#3c3836",
      black = "#282828",
      oceanblue = "#458588",
      white = "#fbf1c7",
      cyan = "#89b482",
      green = "#b8bb26",
      skyblue = "#b16286",
      magenta = "#c14a4a",
      orange = "#d65d0e",
      red = "#ea6962",
      violet = "#d3869b",
      yellow = "#fabd2f"
    },
    vi_mode_colors = {
      NORMAL = 'fg',
      OP = 'green',
      INSERT = 'yellow',
      VISUAL = 'oceanblue',
      BLOCK = 'oceanblue',
      REPLACE = 'violet',
      ['V-REPLACE'] = 'violet',
      ENTER = 'cyan',
      MORE = 'cyan',
      SELECT = 'orange',
      COMMAND = 'green',
      SHELL = 'green',
      TERM = 'green',
      NONE = 'yellow'
    }
  }
)
