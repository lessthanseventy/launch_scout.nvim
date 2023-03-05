-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Pounce fuzzy navigation
keymap("n", "s", "<cmd>Pounce<CR>", opts)
keymap("v", "s", "<cmd>Pounce<CR>", opts)
keymap("o", "gs", "<cmd>Pounce<CR>", opts)

keymap("n", "<leader><leader>", "<cmd>lua vim.api.nvim_feedkeys(':', 'n', true)<cr>", opts)

keymap("n", "<F9>", ":Ttoggle<cr>", opts)
keymap("t", "<F9>", "<C-\\><C-n>:Tclose<cr>", opts)
keymap("t", "jk", "<C-\\><C-n>", opts)

keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<F8>", ":NvimTreeToggle<CR>", opts)

-- Glance
keymap("n", "gr", "<cmd>Glance references<cr>", opts)

-- Yanky
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "<c-y>n", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-y>p", "<Plug>(YankyCycleBackward)")

keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  opts
)

keymap(
  "n",
  "<leader>e",
  "<cmd>lua require('telescope').extensions.file_browser.file_browser({path = '%:p:h', grouped = true})<cr>",
  opts
)
