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

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "elixir" },
  callback = function()
    require("elixir-extras").setup_multiple_clause_gutter()

    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<leader>k",
      "<cmd>lua require('elixir-extras').elixir_view_docs({})<CR>",
      { desc = "Elixir Documentation" }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<leader>K",
      "<cmd>lua require('elixir-extras').elixir_view_docs({include_mix_libs=true})<CR>",
      { desc = "Project Documentation" }
    )
  end,
})

local resession = require("resession")

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(vim.fn.getcwd(), { notify = false })
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

--Update tabby on cursor move
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  pattern = "*",
  callback = function()
    if vim.g.update_tabby then
      require("tabby").update()
    end
  end,
})

-- Disable miniindent
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "alpha", "fzf", "qf", "terminal", "toggleterm", "drex" },
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
