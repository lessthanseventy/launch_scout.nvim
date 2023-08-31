local M = {}
local Terminal = require("toggleterm.terminal").Terminal
local cur_cwd = vim.fn.getcwd()

local btop = Terminal:new({
  cmd = "btop",
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
  -- function to run on closing the terminal
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
})

local lazydocker = Terminal:new({
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-j>", "<C-j>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-k>", "<C-k>", { noremap = true, silent = true })
  end,
  on_close = function(term)
    require("neo-tree.events").fire_event("git_event")
  end,
  cmd = "sleep 0.1 && lazydocker",
  hidden = true,
  direction = "horizontal",
})

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  dir = "git_dir",
  direction = "float",
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-j>", "<C-j>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-k>", "<C-k>", { noremap = true, silent = true })
  end,
  on_close = function(term)
    require("neo-tree.events").fire_event("git_event")
  end,
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
    lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      on_close = function()
        require("neo-tree.events").fire_event("git_event")
      end,
    })
  else
    lazygit:toggle()
  end
end

function M.BTOP_TOGGLE()
  btop:toggle()
end

function M.LAZYDOCKER_TOGGLE()
  lazydocker:open()
end

function M.MIX_TEST_LINE(args)
  local watch = args and args.watch or false
  local lnum = vim.fn.line(".")
  local bufname = vim.api.nvim_buf_get_name(0)
  local cmd = "'mix test"
  if watch then
    cmd = cmd .. ".watch "
  else
    cmd = cmd .. " "
  end
  cmd = cmd .. bufname .. ":" .. lnum .. " --color --trace'"
  local term = require("toggleterm")
  term.exec_command("cmd=" .. cmd, 2)
end

function M.MIX_TEST_FILE(args)
  local watch = args and args.watch or false
  local bufname = vim.api.nvim_buf_get_name(0)
  local cmd = "'mix test"
  if watch then
    cmd = cmd .. ".watch "
  else
    cmd = cmd .. " "
  end
  cmd = cmd .. bufname .. " --color --trace'"
  local term = require("toggleterm")
  term.exec_command("cmd=" .. cmd, 2)
end

function M.MIX_TEST_LIVE(args)
  local watch = args and args.watch or false
  local cmd = "'mix test"
  if watch then
    cmd = cmd .. ".watch "
  else
    cmd = cmd .. " "
  end
  cmd = cmd .. "test/**/live/" .. " --color --trace'"
  local term = require("toggleterm")
  term.exec_command("cmd=" .. cmd, 2)
end

function M.MIX_TEST_ALL(args)
  local watch = args and args.watch or false
  local cmd = "'mix test"
  if watch then
    cmd = cmd .. ".watch "
  else
    cmd = cmd .. " "
  end
  cmd = cmd .. " --color --trace'"
  local term = require("toggleterm")
  term.exec_command("cmd=" .. cmd, 2)
end

function M.VSPLIT()
  local bufname = vim.api.nvim_buf_get_name(0)
  vim.cmd("vsplit " .. bufname)
end

function M.SPLIT()
  local bufname = vim.api.nvim_buf_get_name(0)
  vim.cmd("split " .. bufname)
end

return M
