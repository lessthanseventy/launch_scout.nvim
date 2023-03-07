-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.autowrite = false
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.confirm = false
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars.eob = " "
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
-- vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
vim.opt.guifont = { "Caskaydia Cove Nerd Font Complete", ":h17" }
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.mouse = "nv" -- allow the mouse to be used in neovim
vim.opt.mousemodel = "extend"
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set number column width to 4
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.showtabline = 0 -- always show tabs
vim.opt.signcolumn = "auto:2"
vim.opt.smartindent = true
vim.opt.swapfile = true -- creates a swapfile
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 200 -- faster completion (4000ms default)
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.wildmenu = false
vim.opt.wrap = true -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.g.python3_host_prog = "/usr/bin/python"
vim.g.node_host_prog = "/home/andrew/.asdf/installs/nodejs/19.3.0/bin/neovim-node-host"
vim.g.loaded_perl_provider = 0
vim.g.do_filetype_lua = 1

vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_use_nerd_fonts = 1

vim.cmd([[
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
]])
