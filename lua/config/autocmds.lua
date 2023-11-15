vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "tsplayground" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "oil" },
  callback = vim.schedule_wrap(function()
    vim.b.minianimate_disable = true
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<Esc>",
      "<cmd>lua require('oil').close()<CR>",
      { noremap = true, silent = true }
    )
  end),
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc(-1) == 0 then
      require("telescope").extensions.workspaces.workspaces()
    end
  end,
})

local resession = require("resession")

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(vim.fn.getcwd(), { notify = false })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufWritePost" }, {
  callback = function()
    require("neo-tree.events").fire_event("git_event")
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
  end,
})

-- Disable miniindent
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "alpha", "fzf", "qf", "terminal", "toggleterm", "neo-tree" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.cmd("autocmd FileType dbui nmap <buffer> <c-j> <C-w>j")
vim.cmd("autocmd FileType dbui nmap <buffer> <c-k> <C-w>k")
vim.cmd("autocmd QuickFixCmdPost *grep* cwindow")

local telescope_augroup_id = vim.api.nvim_create_augroup("telescope_settings", {})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = telescope_augroup_id,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "i", false)
    end
  end,
})

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("Cprelpath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
