-- " set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- " let &packpath = &runtimepath
-- " source ~/.vimrc

-- Set some basic options
vim.cmd('set nocompatible')
vim.opt.shell = '/bin/bash'
-- Set leader key to comma (Retained)
vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- Visual plugins
	'nvim-lualine/lualine.nvim',
	'nyoom-engineering/oxocarbon.nvim',
	'morhetz/gruvbox',
	'norcalli/nvim-colorizer.lua',
	'navarasu/onedark.nvim',
	{'lifepillar/vim-solarized8', branch = 'neovim' },
	{ "miikanissi/modus-themes.nvim", priority = 1000 },

	-- Syntax plugins
	'prettier/vim-prettier',
	'sheerun/vim-polyglot',
	'leafgarland/typescript-vim',
	'MaxMEllon/vim-jsx-pretty',
	'elzr/vim-json',
	{
		'stevearc/conform.nvim',
		opts = {},
	},
	'mfussenegger/nvim-lint',
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

	-- Functional plugins
	'SirVer/ultisnips',
	'mlaursen/vim-react-snippets',
	'vim-test/vim-test',
	'scrooloose/nerdtree',
	{'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
	'junegunn/fzf.vim',
	{'akinsho/toggleterm.nvim', version = "*", config = true},

	-- Git plugins
	'tpope/vim-fugitive',
	'airblade/vim-gitgutter',

	-- Shortcut plugins
	'tpope/vim-surround',
	'tpope/vim-commentary',
	'mattn/emmet-vim',

	-- Completion/linting
	{'neoclide/coc.nvim', branch = 'release'},
	{'iamcco/coc-tailwindcss', build = 'yarn install --frozen-lockfile && yarn run build'},
	{'kkoomen/vim-doge', build = function() vim.fn['doge#install']() end}
}


require('lazy').setup(plugins)

-- colors
vim.cmd [[colo solarized8]]

-- lualine
require('lualine').setup {
	options = { theme = 'auto' }
}

require("conform").setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
		},
	})

require('lint').linters_by_ft = {
	python = {'pylint',},
	javascript = {'eslint',},
	typescript = {'eslint',},
}

-- vim.api.nvim_create_autocmd({"InsertLeave"}, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end
-- })

-- Configure global Coc extensions
vim.g.coc_global_extensions = {
  'coc-json',
  'coc-git',
  'coc-css',
  'coc-html',
  'coc-tailwindcss',
  'coc-tsserver',
  'coc-react-refactor',
  'coc-pyright'
}

-- Set Python provider
vim.g.python3_host_prog = '/usr/bin/python3'

-- Make coc-tsserver understand tsx/jsx correctly
vim.cmd([[
  augroup ReactFiletypes
    autocmd!
    autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
    autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
  augroup END
]])

vim.cmd([[
	augroup IndentationPerFileType
	autocmd!
	autocmd FileType javascript setlocal ts=2 sw=2 sts=2 
autocmd FileType typescript setlocal ts=2 sw=2 sts=2
autocmd FileType typescriptreact setlocal ts=2 sw=2 sts=2
autocmd FileType javascriptreact setlocal ts=2 sw=2 sts=2
autocmd FileType css setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal ts=4 sw=4 sts=4
	augroup end
]])

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Enable filetype detection and language-dependent indenting
vim.cmd('filetype plugin indent on')

-- Set specific indentation settings
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false

-- Key Mappings (Retained)
-- Define your keybindings here

-- Configure NERDTree (Retained)
vim.cmd('map <C-n> :NERDTreeToggle<CR>')


-- Other key mappings (Retained)
vim.cmd('imap <M-Space> <Esc>')
vim.cmd('nnoremap <Leader>b :buffers<CR>:buffer<Space>')
vim.cmd('nnoremap <Leader>s :sp<CR>')
vim.cmd('nnoremap <Leader>v :vsp<CR>')
vim.cmd('nmap <silent> <Leader>d <Plug>(doge-generate)')
vim.cmd('tnoremap <Leader><Esc> <C-\\><C-n>')
vim.cmd('nnoremap <Leader>z :so ~/.vimrc<CR>')
vim.cmd('nnoremap <Leader>f :Files<CR>')
vim.cmd('nnoremap <Leader>g :!zeal "<cword>"&<CR><CR>')

vim.cmd('nnoremap <Leader>bd :set bg=dark<CR>')
vim.cmd('nnoremap <Leader>bl :set bg=light<CR>')

vim.cmd('nnoremap <Leader>ts :resize 10<CR>')
vim.g.UltiSnipsExpandTrigger = "<C-J>"

-- Lightline Configuration (Retained)
-- Configure your lightline here

-- Make backspace behave in a sane manner
vim.opt.backspace:append('indent,eol,start')

-- Show line numbers
vim.cmd(':set number')

-- Allow hidden buffers, don't limit to 1 file per window/split
vim.opt.hidden = true

-- Use 24-bit (true-color) mode in Vim/Neovim when outside tmux
if vim.fn.has('nvim') == 1 then
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

-- For Neovim > 0.1.5 and Vim > patch 7.4.1799
if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

