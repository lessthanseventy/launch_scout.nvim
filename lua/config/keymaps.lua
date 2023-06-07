-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Copy current file path to clipboard
keymap("n", "<leader>yP", ":Cppath<cr>", { desc = "Copy absolute path to current file" })
keymap("n", "<leader>yp", ":Cprelpath<cr>", { desc = "Copy relative path to current file" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<C-p>", "<cmd>lua require('utils').PROJECT_FILES()<cr>", opts)

-- Toggles
keymap("n", "<leader>Tz", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
keymap("n", "<leader>Tt", "<cmd>Twilight<cr>", { desc = "Twilight mode" })
keymap("n", "<leader>Tw", "<cmd>WindowsToggleAutowidth<cr>", { desc = "Window animations" })

--Terminal stuff
keymap("n", "<leader>ta", "<cmd>lua require('utils').MIX_TEST_ALL()<cr>", { desc = "Run test suite" })
keymap("n", "<leader>tb", "<cmd>lua require('utils').BTOP_TOGGLE()<cr>", { desc = "Btop" })
keymap("n", "<leader>td", "<cmd>lua require('utils').LAZYDOCKER_TOGGLE()<cr>", { desc = "Lazydocker" })
keymap("n", "<leader>tf", "<cmd>lua require('utils').MIX_TEST_FILE()<cr>", { desc = "Run tests for filfe" })
keymap("n", "<leader>tt", "<cmd>lua require('utils').MIX_TEST_LINE()<cr>", { desc = "Test current line" })
keymap("n", "<leader>tw", "<cmd>lua require('utils').MIX_TEST_WATCH()<cr>", { desc = "Watch test for current line" })
keymap("t", "<C-j><C-k>", "<C-\\><C-n>", opts)

keymap("n", "<leader>gg", "<cmd>lua require('utils').LAZYGIT_TOGGLE()<cr>", { desc = "LazyGit" })
keymap("n", "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit current file" })

--Window management
keymap("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "🟔 🟔 🟔  🚀 🟔 🟔 🟔 " })
keymap("n", "<leader>wd", "<cmd>q!<cr>", { desc = "Close current buffer" })
keymap("n", "<leader>ws", "<C-W>s", { desc = "Split horizontally" })
keymap("n", "<leader>wo", "<Cmd>lua require('utils').WINDOW_OPTIONS()<cr>", { desc = "Print options" })
keymap("n", "<leader>wt", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap("n", "<leader>wv", "<C-W>v", { desc = "Split vertically" })
keymap("n", "<leader>ww", "<cmd>w %<cr>", { desc = "Save current file" })
keymap("n", "<leader>l", "<cmd>Lazy<cr>", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

--Alternate File
keymap("n", "<leader>`", "<cmd>A<cr>", { desc = "Alternate file" })
