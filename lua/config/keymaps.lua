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
keymap("n", "<leader>l", "<cmd>Lazy<cr>", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<F8>", ":NvimTreeToggle<CR>", opts)

-- Alpha
keymap("n", "<leader>a", "<cmd>Alpha<cr>", opts)

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
keymap("t", "jk", "<C-\\><C-n>", opts)
keymap("n", "<leader>gg", "<cmd>lua require('utils').LAZYGIT_TOGGLE()<cr>", { desc = "LazyGit" })
keymap("n", "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit current file" })
keymap("n", "<leader>ww", "<cmd>w %<cr>", { desc = "Save current file" })
keymap("n", "<leader>qq", "<cmd>qa!<cr>", opts)
keymap("n", "<leader>ws", "<C-W>s", { desc = "Split window horizontally" })
keymap("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically" })
keymap("n", "<leader>wt", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader>wd", "<cmd>q!<cr>", { desc = "Close current buffer" })
