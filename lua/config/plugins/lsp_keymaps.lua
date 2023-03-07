local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return {
  ["<C-j>"] = cmp.mapping({
    i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    s = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  }),

  ["<C-k>"] = cmp.mapping({
    i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    s = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  }),

  ["<Tab>"] = cmp.mapping({
    i = function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        fallback()
      end
    end,
    s = function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        fallback()
      end
    end,
    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

  -- ["<Esc>"] = cmp.mapping({
  --   i = function(fallback)
  --     if cmp.visible() and cmp.get_active_entry() then
  --       cmp.abort()
  --     else
  --       fallback()
  --     end
  --   end,
  -- }),

  ["<C-A-Space>"] = cmp.mapping(
    cmp.mapping.complete({
      config = {
        sources = {
          { name = "luasnip" },
        },
      },
    }),
    { "i" }
  ),

  ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),

  ["<CR>"] = cmp.mapping({
    i = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        fallback()
      end
    end,
    s = function()
      cmp.confirm({ select = true })
    end,
    c = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end,
  }),
}
