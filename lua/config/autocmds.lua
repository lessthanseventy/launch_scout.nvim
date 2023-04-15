vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "calendar", "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "dbout" },
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
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<Esc>",
      "<cmd>lua require('oil').close()<CR>",
      { noremap = true, silent = true }
    )
  end),
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

vim.cmd("autocmd FileType dbui nmap <buffer> <c-j> <C-w>j")
vim.cmd("autocmd FileType dbui nmap <buffer> <c-k> <C-w>k")
vim.cmd([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])

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
