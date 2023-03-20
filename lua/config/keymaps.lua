-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

keymap("n", "<leader>ww", "<cmd>w! %<cr>", opts)
keymap("n", "<leader>qq", "<cmd>qa!<cr>", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<F8>", ":NvimTreeToggle<CR>", opts)

-- Glance
keymap("n", "gr", "<cmd>Glance references<cr>", opts)
keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
keymap("n", "<leader>a", "<cmd>Alpha<cr>", opts)

-- Yanky
keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap("n", "<c-y>n", "<Plug>(YankyCycleForward)")
keymap("n", "<c-y>p", "<Plug>(YankyCycleBackward)")

keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{hidden=true, previewer = false})<cr>",
  opts
)

keymap(
  "n",
  "<leader>e",
  "<cmd>lua require('telescope').extensions.file_browser.file_browser({path = '%:p:h', grouped = true, hidden = true})<cr>",
  { desc = "Browse current directory" }
)

--Terminal stuff
keymap("n", "<leader>ta", "<cmd>lua require('utils').MIX_TEST_ALL()<cr>", { desc = "Run test suite" })
keymap("n", "<leader>tb", "<cmd>lua require('utils').BTOP_TOGGLE()<cr>", { desc = "Btop" })
keymap("n", "<leader>td", "<cmd>lua require('utils').LAZYDOCKER_TOGGLE()<cr>", { desc = "Lazydocker" })
keymap("n", "<leader>tf", "<cmd>lua require('utils').MIX_TEST_FILE()<cr>", { desc = "Run tests for filfe" })
keymap("n", "<leader>tt", "<cmd>lua require('utils').MIX_TEST_LINE()<cr>", { desc = "Test current line" })
keymap("n", "<leader>tw", "<cmd>lua require('utils').MIX_TEST_WATCH()<cr>", { desc = "Watch test for current line" })
keymap("t", "qq", "<C-\\><C-n>", opts)

--deal with lazyvim defaults
keymap("n", "<leader>gg", "<cmd>lua require('utils').LAZYGIT_TOGGLE()<cr>", { desc = "LazyGit" })
keymap("n", "<leader>gG", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit current file" })
keymap("n", "<leader>ww", "<cmd>w %<cr>", { desc = "Save current file" })
keymap("n", "<leader>qq", "<cmd>qa!<cr>", opts)
keymap("n", "<leader>ws", "<C-W>s", { desc = "Split window horizontally" })
keymap("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically" })
keymap("n", "<leader>wt", "<cmd>tabnew<cr>", { desc = "New Tab" })

vim.keymap.del("n", "<leader>wd")
keymap("n", "<leader>wd", "<cmd>q!<cr>", { desc = "Close current buffer" })

vim.keymap.del({ "n", "i" }, "<Esc>")
vim.keymap.del({ "n", "i" }, "<M-j>")
vim.keymap.del({ "n", "i" }, "<M-k>")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>fn")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
