-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = false
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
opt.completeopt = "menuone,noinsert,noselect" -- mostly just for cmp"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = false
opt.cursorline = true
opt.equalalways = false
opt.expandtab = true
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.fillchars.eob = " "
opt.foldcolumn = "0"
opt.foldenable = false
opt.foldlevelstart = 99
opt.guifont = { "Cascadia Code PL", ":h12" }
opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,i:blinkwait700-blinkoff500-blinkon200,a:Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.laststatus = 3
opt.list = true
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.mousemodel = "extend"
opt.mousemoveevent = true
opt.number = true -- set numbered lines
opt.numberwidth = 4 -- set number column width to 4
opt.pumblend = 10
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true
opt.ruler = false
opt.sessionoptions = "buffers,curdir,folds,options,help,tabpages,resize,winpos,winsize"
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.showtabline = 2 -- always show tabs
opt.signcolumn = "yes:2"
opt.smartindent = false
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.startofline = true
opt.swapfile = true -- creates a swapfile
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 175 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.undolevels = 10000
opt.whichwrap:append("<,>,[,],h,l")
opt.wildmenu = false
opt.wrap = true -- display lines as one long line
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.g.python3_host_prog = "/usr/bin/python"
vim.g.loaded_perl_provider = 0
vim.g.do_filetype_lua = 1
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.update_tabby = true
--
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.cmd([[
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
]])
