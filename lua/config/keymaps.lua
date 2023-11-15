local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

keymap(
  "n",
  "<leader>nc",
  "<cmd>lua require('mini.files').open('/home/andrew/.config/nvim/lua/')<cr>",
  { desc = "Edit neovim configuration" }
)
keymap("n", "<leader>nl", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Center screen after common actions
-- keymap("n", "n", "nzz", opts)
-- keymap("n", "N", "Nzz", opts)

-- Copy current file path to clipboard
keymap("n", "<leader>yP", ":Cppath<cr>", { desc = "Copy absolute path to current file" })
keymap("n", "<leader>yp", ":Cprelpath<cr>", { desc = "Copy relative path to current file" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Toggles
keymap("n", "<leader>Tz", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
keymap("n", "<leader>Tt", "<cmd>Twilight<cr>", { desc = "Twilight mode" })
keymap("n", "<leader>Tw", "<cmd>WindowsToggleAutowidth<cr>", { desc = "Window animations" })

--Terminal stuff
keymap("n", "<leader>ta", "<cmd>lua require('utils').MIX_TEST_ALL()<cr>", { desc = "Run test suite" })
keymap("n", "<leader>tl", "<cmd>lua require('utils').MIX_TEST_LIVE()<cr>", { desc = "Run live tests" })
keymap(
  "n",
  "<leader>tL",
  "<cmd>lua require('utils').MIX_TEST_LIVE(watch = true)<cr>",
  { desc = "Run live tests (watch)" }
)
keymap("n", "<leader>tf", "<cmd>lua require('utils').MIX_TEST_FILE()<cr>", { desc = "Run tests for file" })
keymap(
  "n",
  "<leader>tF",
  "<cmd>lua require('utils').MIX_TEST_FILE(watch = true)<cr>",
  { desc = "Run tests for file (watch)" }
)
keymap("n", "<leader>trb", "<cmd>lua require('utils').BTOP_TOGGLE()<cr>", { desc = "Btop" })
keymap("n", "<leader>trd", "<cmd>lua require('utils').LAZYDOCKER_TOGGLE()<cr>", { desc = "Lazydocker" })
keymap("n", "<leader>tt", "<cmd>lua require('utils').MIX_TEST_LINE()<cr>", { desc = "Test current line" })
keymap(
  "n",
  "<leader>tT",
  "<cmd>lua require('utils').MIX_TEST_LINE(watch = true)<cr>",
  { desc = "Test current line (watch)" }
)
keymap("t", "<C-j><C-k>", "<C-\\><C-n>", opts)

keymap("n", "<leader>gg", "<cmd>lua require('utils').LAZYGIT_TOGGLE()<cr>", { desc = "LazyGit" })
keymap("n", "<leader>gbf", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit current file" })

--Window management
keymap("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "🟔 🟔 🟔  🚀 🟔 🟔 🟔 " })
keymap("n", "<leader>wd", "<cmd>q!<cr>", { desc = "Close current buffer" })
keymap("n", "<leader>ws", "<cmd>lua require('utils').SPLIT()<cr>", { desc = "Split horizontally" })
keymap("n", "<leader>wt", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap("n", "<leader>wv", "<cmd>lua require('utils').VSPLIT()<cr>", { desc = "Split vertically" })
keymap("n", "<leader>ww", "<cmd>w %<cr>", { desc = "Save current file" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

--Alternate File
keymap("n", "<leader>`", "<cmd>A<cr>", { desc = "Alternate file" })
