local M = {}

local utils = require("utils")
local nls_utils = require("config.plugins.lsp.null-ls.utils")
local nls_sources = require("null-ls.sources")
local api = vim.api

local method = require("null-ls").methods.FORMATTING

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    utils.info("Enabled format on save", "Formatting")
  else
    utils.warn("Disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    local view = vim.fn.winsaveview()
    vim.lsp.buf.format({
      timeout_ms = 2000,
      filter = function(client)
        return client.name ~= "tsserver"
            and client.name ~= "jsonls"
            and client.name ~= "html"
            and client.name ~= "jdt.ls"
      end,
    })
    vim.fn.winrestview(view)
  end
end

function M.setup(client, bufnr)
  local filetype = api.nvim_buf_get_option(bufnr, "filetype")

  local enable = false

  if M.has_formatter(filetype) then
    enable = client.name == "null-ls"
  else
    enable = client.name ~= "null-ls"
  end

  client.server_capabilities.documentFormattingProvder = enable
  client.server_capabilities.documentRangeFormattingProvider = enable
end

function M.has_formatter(filetype)
  local available = nls_sources.get_available(filetype, method)
  return #available > 0
end

function M.list_registered(filetype)
  local registered_providers = nls_utils.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

function M.list_supported(filetype)
  local supported_formatters = nls_sources.get_supported(filetype, "formatting")
  table.sort(supported_formatters)
  return supported_formatters
end

return M
