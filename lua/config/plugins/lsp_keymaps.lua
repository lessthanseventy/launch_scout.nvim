local LSPMaps = {}
local npairs = require("nvim-autopairs")

LSPMaps.BS = function()
  return vim.fn.pumvisible() == 1 and "<C-e><BS>" or "<BS>"
end

LSPMaps.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return npairs.esc("<c-y>")
    else
      return npairs.esc("<c-e>") .. npairs.esc("<c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

LSPMaps.Esc = function()
  return vim.fn.pumvisible() == 1 and "<C-e><Esc>" or "<Esc>"
end

LSPMaps.C_c = function()
  return vim.fn.pumvisible() == 1 and "<C-e><C-c>" or "<C-c>"
end

LSPMaps.C_j = function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-w>j"
end

LSPMaps.C_k = function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-w>k"
end

LSPMaps.Tab = function()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info().selected == -1 then
      return "<C-n><C-y>"
    else
      return "<C-y>"
    end
  else
    return "<Tab>"
  end
end

LSPMaps.S_Tab = function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<BS>"
end

return LSPMaps
