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
--                    A config file.
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
  -- use 'tjdevries/colorbuddy.vim'
  -- use {'tjdevries/gruvbuddy.nvim', require = 'tjdevries/colorbuddy.vim'}
  use 'morhetz/gruvbox'
  use '9mm/vim-closer'
  use 'tpope/vim-surround'
  use 'justinmk/vim-sneak'
  use 'neovim/nvim-lspconfig'
  use 'junegunn/fzf.vim'
  use 'mileszs/ack.vim'
end)


---------
-- lsp --
---------
require'lspconfig'.rust_analyzer.setup{}


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
map('n', '<Leader>.', ':Files<CR>')
map('n', '<Leader>>', ':GFiles<CR>')
map('n', '<Leader>,', ':Buffers<CR>')
map('n', '<Leader>/', ':Rg<CR>')
map('n', '<Leader>n', ':Explore<CR>')
map('n', '<Leader>q', ':close<CR>')
