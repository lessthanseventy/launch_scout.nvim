local M = {}
local Terminal = require("toggleterm.terminal").Terminal
local cur_cwd = vim.fn.getcwd()

local btop = Terminal:new({
  cmd = "btop",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

local lazydocker = Terminal:new({
  cmd = "lazydocker",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
})

local diagnostics_active = false
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
  else
    vim.diagnostic.config({ virtual_lines = false })
  end
end

function M.leave_snippet()
  if
    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

function M.LAZYGIT_TOGGLE()
  -- cwd is the root of project. if cwd is changed, change the git.
  local cwd = vim.fn.getcwd()
  if cwd ~= cur_cwd then
    cur_cwd = cwd
    lazygit:close()
    lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
  else
    lazygit:toggle()
  end
end

function M.BTOP_TOGGLE()
  btop:toggle()
end

function M.LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

function M.MIX_TEST_LINE()
  local lnum = vim.fn.line(".")
  local bufname = vim.api.nvim_buf_get_name(0)
  local betterTerm = require("betterTerm")
  local cmd = "mix test " .. bufname .. ":" .. lnum .. " --color --trace"
  betterTerm.send(cmd, 1, { clean = false, interrupt = false })
end

function M.MIX_TEST_FILE()
  local bufname = vim.api.nvim_buf_get_name(0)
  local betterTerm = require("betterTerm")
  local cmd = "mix test " .. bufname .. " --color --trace"
  betterTerm.send(cmd, 1, { clean = false, interrupt = false })
end

function M.MIX_TEST_ALL()
  local betterTerm = require("betterTerm")
  local cmd = "mix test --color --trace"
  betterTerm.send(cmd, 1, { clean = false, interrupt = false })
end

function M.MIX_TEST_WATCH()
  local lnum = vim.fn.line(".")
  local bufname = vim.api.nvim_buf_get_name(0)
  local betterTerm = require("betterTerm")
  local cmd = "mix test.watch " .. bufname .. ":" .. lnum .. " --color --trace"
  betterTerm.send(cmd, 1, { clean = false, interrupt = false })
end

return M
